/*Begin ~source text start~*/
% Source path: src/code/prepend_code.pl

exists_extension(jupyter_book, swi_prolog).
exists_extension(jupyter_book, swish).
/*End ~source text start~*/

/*This part is inherited from: swish:iq*/
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).
/*This is the end of inheritance.*/

/*This part is inherited from: swish:hide*/
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).
/*This is the end of inheritance.*/

exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, ExplicitQuery).
*/

/*Begin ~source text end~*/
% Source path: src/code/append_code.pl

exists_extension(jupyter_book, exercise_admonition).
exists_extension(jupyter_book, solution_admonition).
/*End ~source text end~*/
