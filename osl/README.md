# Notice

The book contains some shader code inconsistencies with regard to how the spatial input parameter is handled.
The short answer for this is that I ran out of time to give the book's examples a thorough unifying code review
prior to publication.

I have since done that, and this repoitory's shaders contain consistently implemented spatial parameter initializations and usage.

Of note is the **Space** parameter's default value of <tt>P</tt>
This is to ensure that differential computations based on **Space**, which includes any patterns derived from it, will function properly.
It also simplifies the fallback code in case there is no input connection made to **Space**.
And while I included the fallback use of *"object"* space <tt>Po</tt> as a convenience to shader authors
when a **Space** parameter connection is not supplied, the best practice is to always provide such a connection so the
pattern generation space is explicitly specified in the shading network.
