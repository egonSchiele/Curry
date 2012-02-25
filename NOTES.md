Considerations:

lambdas aren't exported from the module. I just stuck them all inside methods instead of variable names and that's fine. But it seems like lambda's just aren't as easy to work with. They also arent bound to an object like a method is.

When an error is thrown, the stack looks all messed up. So even if you convert your lambdas into proper methods, when the user uses your methods incorrectly, they will be shown a pretty incomprehensible stack trace.

The methods *, [] and << are now on all Procs forever. If someone uses this project, and then another person uses their project, they will all inherit these methods, whether they want to or not.
