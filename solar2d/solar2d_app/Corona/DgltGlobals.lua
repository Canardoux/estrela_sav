

Phase = 'QUESTION' -- 'ANSWER'  'PREVIOUS' 'BROWSE'

Mode = 'TEST' -- 'HANJA' 'DEF' 'BROWSE' 'TEACHER_BROWSE'

TeacherMode = true

Student = 'Larpoux'
HasAlternateTranscriptions = false
AlternateTranscription = 'Hanja'

TotalRight = 0
totalWrong = 0

Stacks =
{
        UNTESTED = 1234,
        NEW = 1235,
        RECENT = 1236,
        OLDER = 1237,
        ANCIENT = 1238
}

function GetScore()
        if TotalRight + totalWrong == 0 then
                return 100
        else
                return TotalWright / (TotalWright + TotalWrong)
        end
end