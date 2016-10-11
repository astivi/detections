Detections
==========

About
-----

Given a file with tracks and radios in which these track were played, figures out the genre of each song by clustering data.

Usage
-----

> ruby {inputFile} {similarityThreshold}

Similarity threshold stands for a value between 0.0 and 1.0 which represents the minimum likeness between two distinct genres so that they can be merged into one.

Output
------

Output goes into {projectDir}/output/{inputFile}.by_source and {projectDir}/output/{inputFile}.by_track

Tests
-----

> bundle exec rspec

References
----------

Code was based on these two references:
> http://www.cs.utah.edu/~piyush/teaching/4-10-print.pdf
> http://home.deib.polimi.it/matteucc/Clustering/tutorial_html/hierarchical.html
