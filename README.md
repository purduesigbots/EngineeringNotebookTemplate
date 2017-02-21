##Purdue ACM SIGBots Engineering Notebook v1.0
___


######Created by Jonathan Bayless of Team BLRS
Contact: baylessj@purdue.edu


This template is designed to create a more flexible and robust environment for the development of an engineering notebook for the VEX Robotics Competition. Users may input their team's information and build logs for each season, and the template will handle formatting and a variety of other tasks necessary for making a printable and pleasant looking document.



###User Guide

####Creating Git Commit Logs
* The main steps for this (as well as the BASH script for this process) can be found at http://amritamaz.net/blog/gitlog2latex-pretty-git-commit-logs-in-latex
* A few minor changes will need to be made to this process, however. The set of steps to run this script should include:
	* Navigate to your desired git directory in BASH (or BASH for Windows)
    * curl -O https://gist.githubusercontent.com/amritamaz/68d72c602a29635168ed/raw/4a2f064142b08f3c021e9a7562ec9116c0490cbf/gitlog2latex.sh
	* export GHCRTS=-V0
    * chmod a+x gitlog2latex.sh
    * ./gitlog2latex.sh
* The script will then be present in your git directory (add it to the .gitignore file if you don't want it to be pushed with your code)
* You will then need to copy and paste the contents of this newly created gitlog file into the desired section of your engineering notebook.
* **You will need to modify the gitlog output to work with LaTeX**. Unfortunately the script does not create output that can compile, but luckily it just requires a minor change. Make sure the top portion of the output matches this:

```
\begin{center}
\begin{longtabu} to \textwidth {|
    X[4,l]|
    X[3,c]|
    X[8,l]|}
    \hline
    \textbf{Author} & \textbf{Date} & \textbf{Message} \\ \hline
```

ensuring that there are two backslash characters before the final "\hline" command.

####Adding PROS Code to an iteration
There is a BASH script provided in this repo for use in a PROS directory. When the script is run in a PROS directory (and the name of the directory for the LaTeX notebook is specified), a .tex file will be created that will import your PROS code wherever you copy and paste the contents of the .tex in your notebook (complete with syntax highlighting too). API.h is omitted from this automatically.

The notebook's directory should be in the same folder as the PROS directory.

The syntax for running the script should be:
```
PROS_DIRECTORY/$: ./prosToMinted.sh NOTEBOOK_DIRECTORY
```
####Editing in Atom
* Atom will work well for editing the notebook, and in many ways performs better than Overleaf, but only with the right configuration.
* Install the following packages:
	* language-latex
	* latex
	* latex-autocomplete
* Change the following Atom settings:
	* In Settings->Editor, turn on Soft Wrap and/or Soft Wrap at Preferred Line Length, as this will allow LaTeX's style of having paragraphs on a single line fit nicely onto your screen.
* You will need to have git set up with Overleaf's clone address, and then push and pull the repo manually. This will require an additional step compared to Overleaf, but allows you to mark major revisions with commit messages, ensuring more reliable use.

####General Formatting
* if you need to insert a blank line, "~\\" is the best way to accomplish that.
* the "verbatim" environment should be used any time that a code block is being added to the notebook, though \verb!INSERT_TEXT_HERE! should be used for referencing bits of code inline (i.e. variable names)
* Common text commands:
	* Italics: \textit{}
	* Bold: \textbf{}
    * Small Caps: \textsc{}


####Chapter/Section Formatting
* Chapters should be initialized by setting the \chapter as a description of the iteration (i.e. Summer Build) or intro material section. The label will go in square brackets ("[]") and the displayed chapter name will go in curly brackets ("{}").
	* this same format should be used for sections and subsections as well

"%-----------------------------------------"

* Chapters, sections, and subsections should have a comment line above them (like above) to make it easier to navigate the document when in code form.
* Most sections within a chapter should have a design methodology section, which is created as an environment in the SIGBotsEngineeringNotebook class file. Chapter 1 should be a good example of this.
* Proper indenting is extremely important in tracking the organization level when doing bulleted lists. Make sure that the \begin and \end tags are at the same indentation level as their items.
* Whenever referencing established design concepts, using \hyperref[label_name]{"actual_text"} to cross reference the document is recommended.
	* if the figure/section number is desired instead of a custom display text, \autoref{label_name} may be used.
    * URLs can be linked to custom label text through use of the \href{url}{"actual_text"} command


####Adding Images
* the formatting and labeling for images is automatically generated by using the \insertimage macro. The arguments for this function are {"file_name"}{"Description_of_image"}
* All images should be labeled in camel case and stored in the Figures folder


####Build Timeline
* entries in the Build Timeline should be tagged by their dates as such:
	{\noindent\bfseriesINSERT_DATE_HERE}


####Things to Watch For
* MS Word automatically changes quotation marks to slanted kinds (a different ASCII character), so quotes and apostrophes will not show up in LaTeX at first when text gets copied.
* MAKE SURE ALL URLS ARE TAGGED AS SUCH! URLs in citations need to be marked with the \url{} tag to ensure that special characters such as tildes and underscores do not get read by the TeX compiler and screw things up. Plus tagging all URLs makes it easier to track sources. Generally just an important thing to do.
	* additional note, while \url while keep these characters from getting compiled, special characters still will not show up until preceded by a "\" character, so check through any links you add.
* Watch out for LaTeX's special characters when moving info over from word, things like asterisks, percent signs, and tildes need corrected, usually by placing a backslash in front of them
