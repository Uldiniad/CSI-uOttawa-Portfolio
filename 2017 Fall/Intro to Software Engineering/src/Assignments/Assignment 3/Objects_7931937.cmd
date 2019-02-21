-- 1. Five instances of class Student
!create peter:Student
!create oliver:Student
!create ivor:Student
!create macky:Student
!create hansel:Student

!set peter.firstName := 'Peter'
!set oliver.firstName := 'Oliver'
!set ivor.firstName := 'Ivor'
!set macky.firstName := 'Macky'
!set hansel.firstName := 'Hansel'
!set peter.lastName := 'Quill'
!set oliver.lastName := 'Scott'
!set ivor.lastName := 'Benderavage'
!set macky.lastName:= 'Backayoko'
!set hansel.lastName := 'Timon'
!set peter.number := '123456'
!set oliver.number := '7931937'
!set ivor.number := '8171462'
!set macky.number := '7937496'
!set hansel.number := '8731928'
!set peter.email := 'peter.chill@guardians.org'
!set oliver.email := 'oscot042@uottawa.ca'
!set ivor.email := 'ibend067@uottawa.ca'
!set macky.email := 'mbaka101@uottawa.ca'
!set hansel.email := 'hngie033@uottawa.ca'
!set peter.cgpa := 6.5
!set oliver.cgpa := 8.5
!set ivor.cgpa := 8.5
!set macky.cgpa := 8.5
!set hansel.cgpa := 8.5
!set peter.year := 3
!set oliver.year := 3
!set ivor.year := 3
!set macky.year := 3
!set hansel.year := 3
!set peter.faculty := 'Engineering'
!set oliver.faculty := 'Engineering'
!set ivor.faculty := 'Engineering'
!set macky.faculty := 'Engineering'
!set hansel.faculty := 'Engineering'
!set peter.program := 'Computer Science'
!set oliver.program := 'Computer Science'
!set ivor.program := 'Computer Engineering'
!set macky.program := 'Computer Engineering'
!set hansel.program := 'Software Engineering'
!set peter.motherTongue := Mothertongue::ENGLISH
!set oliver.motherTongue := Mothertongue::OTHER
!set ivor.motherTongue := Mothertongue::ENGLISH
!set macky.motherTongue := Mothertongue::FRENCH
!set hansel.motherTongue := Mothertongue::ENGLISH

-- 2. Six instances of Scholarship. Three regular scholarships (two of them are mutually exclusive), two admission scholarships, one French bursary scholarship.
!create french:FrenchScholarship
!create admissionA:AdmissionScholarship
!create admissionB:AdmissionScholarship
!create scholarshipA:Scholarship
!create scholarshipB:Scholarship
!create scholarshipC:Scholarship

!create fallScholarships:ScholarshipGroup

!set french.name := 'French Studies'
!set admissionA.name := 'Renewable Admission Scholarship'
!set admissionB.name := 'Non-renewable Admission Scholarship'
!set scholarshipA.name := 'Scholarship A'
!set scholarshipB.name := 'Scholarship B'
!set scholarshipC.name := 'Scholarship C'
!set scholarshipA.value := 1000
!set scholarshipB.value := 1000
!set scholarshipC.value := 1000
!set scholarshipA.cgpa := 9
!set scholarshipB.cgpa := 9.5
!set scholarshipC.cgpa := 8.5
!set scholarshipA.year := 1
!set scholarshipB.year := 2
!set scholarshipC.year := 2
!set scholarshipA.faculty := 'Engineering'
!set scholarshipB.faculty := 'Engineering'
!set scholarshipC.faculty := 'Engineering'
!set scholarshipA.program := 'Computer Science'
!set scholarshipB.program := 'Computer Engineering'
!set scholarshipC.program := 'Software Engineering'
!set scholarshipA.recipients := 1
!set scholarshipB.recipients := 2
!set scholarshipC.recipients := 3
!set scholarshipA.availability := Semester::FALL
!set scholarshipB.availability := Semester::FALL
!set scholarshipC.availability := Semester::WINTER
!set scholarshipA.deadline := '2017-09-29'
!set scholarshipB.deadline := '2017-10-29'
!set scholarshipC.deadline := '2018-02-29'
!set scholarshipA.recurrent := true
!set scholarshipB.recurrent := true
!set scholarshipC.recurrent := false
!set admissionA.recurrent := true
!set admissionB.recurrent := false
!set french.recurrent := true
!set scholarshipA.kind := fallScholarships
!set scholarshipB.kind := fallScholarships

-- 3. Five instances of an application
!insert (scholarshipA,peter) into Application
!insert (scholarshipA,oliver) into Application
!insert (scholarshipB,ivor) into Application
!insert (scholarshipB,macky) into Application
!insert (scholarshipC,hansel) into Application


-- 4. Other
!insert (fallScholarships,scholarshipA) into ScholarshipGroupContainsScholarships
!insert (fallScholarships,scholarshipB) into ScholarshipGroupContainsScholarships

!create recommender:Recommender
!insert (recommender,Application1) into Letter
!insert (recommender,Application2) into Letter
!insert (recommender,Application3) into Letter
!insert (recommender,Application4) into Letter
!insert (recommender,Application5) into Letter

!set recommender.relationship := Relationship::PROFESSOR