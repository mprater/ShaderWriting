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

# RenderMan for Maya

Autodesk Maya requires that every node, shading or otherwise, have a unique identifier.
For shading nodes, these identifiers are specified with shader metadata, much like parameters can have metadata associated with them.
I have included the rfm_nodeid and rfm_classification metadata in each shader so they are ready to use with RenderMan for Maya.
If you want to add your own OSL shaders for use in Maya, you'll need to assign them their own unique rfm_nodeid values.
Autodesk provides blocks of these id values here: https://mayaid.autodesk.io/
