
#let problem_counter = counter("problem")

#let prob(body, val) = {
  // let current_problem = problem_counter.step()
  [== #val] 
  block(fill:rgb(250, 255, 250),
   width: 100%,
   inset:8pt,
   radius: 4pt,
   stroke:rgb(31, 199, 31),
   body)
  }

// Some math operators
#let prox = [#math.op("prox")]
#let proj = [#math.op("proj")]
#let argmin = [#math.arg]+[#math.min]
#let inlinefrac(a, b) = { return $#super(a) #h(-1pt) slash #h(-1pt) #sub(b)$ }


// Initiate the document title, author...
#let assignment_class(title, author, course_id, semester, body) = {
  set document(title: title, author: author)
  set page(
    paper:"us-letter", 
    header: locate( 
        loc => if (
            counter(page).at(loc).first()==1) { none } 
        else if (counter(page).at(loc).first()==2) { align(right, 
              [*#author* | *#course_id: #title* | *Задача 1*]
            ) }
        else { 
            align(right, 
              [*#author* | *#course_id: #title* | *Задача #problem_counter.at(loc).first()*]
            ) 
        }
    ), 
    footer: locate(loc => {
      let page_number = counter(page).at(loc).first()
      let total_pages = counter(page).final(loc).last()
      align(center)[Page #page_number of #total_pages]
    }))
  block(height:25%,fill:none)
  align(center, text(17pt)[
    *#course_id: #title*])

  align(center, [#semester])
  block(height:35%,fill:none)
  align(center)[*#author*]
  
  pagebreak(weak: false)
  body
  
    // locate(loc => {
    //   let i = counter(page).at(loc).first()
    //   if i == 1 { return }
    //   set text(size: script-size)
    //   grid(
    //     columns: (6em, 1fr, 6em),
    //     if calc.even(i) [#i],
    //     align(center, upper(
    //       if calc.odd(i) { title } else { author-string }
    //     )),
    //     if calc.odd(i) { align(right)[#i] }
    //   )
    // })

//   if student_number != none {
//     align(top + left)[Student number: #student_number]
//   }

//   align(center)[= #title]
}

#import "@preview/ctheorems:0.1.0": *

#let theorem(body) = {
  block(fill:rgb(250, 250, 250),
   width: 100%,
   inset:8pt,
   radius: 4pt,
   stroke:rgb(50, 50, 50),
   [#body])
  }

#let spaceb = $space space space$
