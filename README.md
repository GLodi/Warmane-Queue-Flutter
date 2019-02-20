# Warmane Queue Flutter

A Flutter app that parses Warmane's website and extracts queues' information.

It implements a version of BLoC that I've learned from Didier Boelens:
https://www.didierboelens.com/2018/12/reactive-programming---streams---bloc---practical-use-cases/

The main difference from a regular BLoC approach is that it implements 
Event-States in order to manage a screen's state. 

I've also used kiwi to generate all dependencies (not really a 
dependency injection system, as Flutter doesn't have a straightforward 
solution for it yet).