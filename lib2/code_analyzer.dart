import 'dart:io';
import 'package:ansicolor/ansicolor.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

final yellow = AnsiPen()..yellow();
final green = AnsiPen()..green();
final red = AnsiPen()..red();

void main() async {
  const projectDir = 'D:/flutter_projects/performance_demo/lib';
  final analyzer = Analyzer(projectDir);
  final analysis = await analyzer.analyze();

  for (var analysisResult in analysis.results) {
    final complexity = _calculateComplexity(analysisResult.unit);
    final codeSmells = _detectCodeSmells(analysisResult.unit);
    final performanceIssues = _detectPerformanceIssues(analysisResult.unit);

    print(yellow('File: ${analysisResult.filePath.substring(41)}'));
    if (complexity == 0 && codeSmells.isEmpty && performanceIssues.isEmpty) {
      print(green('All good! No issues detected.\n'));
    } else {
      print('Complexity: $complexity');

      if (codeSmells.isNotEmpty) {
        print(red('Code Smells:'));
        for (var smell in codeSmells) {
          print(red('- $smell'));
        }
      } else {
        print(green('No code smells detected.'));
      }

      if (performanceIssues.isNotEmpty) {
        print(red('Performance Issues:'));
        for (var issue in performanceIssues) {
          print(red('- $issue'));
        }
      } else {
        print(green('No performance issues detected.'));
      }
      print('\n');
    }
  }
}

int _calculateComplexity(CompilationUnit unit) {
  int complexity = 0;
  for (final declaration in unit.declarations) {
    if (declaration is FunctionDeclaration) {
      final functionBody = declaration.functionExpression.body;
      if (functionBody is BlockFunctionBody) {
        complexity += functionBody.block.statements.length.toInt();
      } else if (functionBody is ExpressionFunctionBody) {
        complexity += 1;
      }
    }
  }
  return complexity;
}

List<String> _detectCodeSmells(CompilationUnit unit) {
  var codeSmells = <String>[];
  for (final declaration in unit.declarations) {
    if (declaration is FunctionDeclaration) {
      final functionBody = declaration.functionExpression.body;
      if (functionBody is BlockFunctionBody) {
        if (functionBody.block.statements.length > 10) {
          codeSmells.add(
              'Long method: ${declaration.name} at line ${_getLineNumber(unit, declaration)}');
        }
      }
    }
  }
  return codeSmells;
}

List<String> _detectPerformanceIssues(CompilationUnit unit) {
  List<String> performanceIssues = <String>[];
  for (final declaration in unit.declarations) {
    if (declaration is FunctionDeclaration) {
      final functionBody = declaration.functionExpression.body;
      if (functionBody is BlockFunctionBody) {
        for (final statement in functionBody.block.statements) {
          if (statement is ForStatement) {
            performanceIssues.add(
                'Potential performance issue: nested loop in ${declaration.name} at line ${_getLineNumber(unit, statement)}');
          }
        }
      }
    }
  }
  return performanceIssues;
}

int _getLineNumber(CompilationUnit unit, AstNode node) {
  var lineInfo = unit.lineInfo;
  return lineInfo.getLocation(node.offset).lineNumber;
}

class Analyzer {
  final String projectDir;

  Analyzer(this.projectDir);

  Future<Analysis> analyze() async {
    final files = await _getDartFiles();
    final analysis = Analysis();

    for (final file in files) {
      final unit = await _parseFile(file);
      analysis.addResult(file.path, unit);
    }

    return analysis;
  }

  Future<List<File>> _getDartFiles() async {
    final files = <File>[];
    try {
      final libDir = Directory(projectDir);
      await for (final file in libDir.list(recursive: true)) {
        if (file is File && file.path.endsWith('.dart')) {
          files.add(file);
        }
      }
    } catch (e) {
      print('Error accessing directory: $e');
    }
    return files;
  }

  Future<CompilationUnit> _parseFile(File file) async {
    final result = parseFile(
      path: file.path,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    if (result.errors.isNotEmpty) {
      throw Exception('Failed to parse file: ${result.errors.join(', ')}');
    }
    return result.unit;
  }
}

class Analysis {
  final List<AnalysisResult> results = [];

  void addResult(String filePath, CompilationUnit unit) {
    results.add(AnalysisResult(filePath, unit));
  }
}

class AnalysisResult {
  final String filePath;
  final CompilationUnit unit;

  AnalysisResult(this.filePath, this.unit);
}
