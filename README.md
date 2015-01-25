---
title: "README.md"
output: html_document
---

This application is a calculator for solving binomic equations. Their solutions are a generalization of the concept of "root of unity". For more information, please check *http://en.wikipedia.org/wiki/Root_of_unity*. Binomic equations appear in many fields of mathematics such as number theory and the discrete Fourier transform.

The input data of the application is 

* the degree of the equation, $n$, which is a natural number between 1 and 20,
* the real and imaginary parts of a complex number $c$, which is called the centre, and
* the real and imaginary parts of a complex number $A$. 

The application finds all complex numbers $z$ such that $(z-c)^n = A$. 

In the first tab of the application we input the data and we print the solutions. This is done after the "Solve" button has been pressed. There is another button called "Plot" which plots the solutions of the equation in the second tab of the application. 

The application is available at *http://tralalilu.shinyapps.io/binomic/*.
