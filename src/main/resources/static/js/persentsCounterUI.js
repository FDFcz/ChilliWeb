
var persentsCounteiner = document.getElementsByClassName("persents");
var dayLeft =  document.getElementsByClassName("dayLeft");
var growDays = document.getElementsByClassName("dayToGrow");
var day;
var mouth;
var year;
var currentDate= new Date();
currentDate.setMonth(currentDate.getMonth() + 1);
var plantedDay = new Date();

for (i = 0;i<dayLeft.length;i++) {
    plantedDay = new Date();
    separateDate(i)
    plantedDay.setFullYear(year);
    plantedDay.setMonth(mouth);
    plantedDay.setDate(day);

    remaningDays = growDays[i].textContent - DaysBetween(plantedDay,currentDate);
    let p1 = (remaningDays/ (growDays[i].textContent/100));
    p1.toFixed(0);
    if (p1<0) p1=0;

    dayLeft[i].textContent = remaningDays+"  ("+(100-p1)+"%)";

    persentsCounteiner[i].style.backgroundColor = "rgb("+getColorR(p1)+","+getColorG(p1)+",0)"
}
function getColorR(x)
{
    if(x<50)return 255;
    return Math.round((100-x)*2*(2.25));
}
function getColorG(x)
{
    if(x>50)return 255;
    return Math.round(2*x*(2.25));
}

function separateDate(n)
{
    let iterator=0
    let stbuilder=""
    for (let i = 0; i < dayLeft[n].textContent.length; i++) {
        if(dayLeft[n].textContent[i]=="-")
        {
            if(iterator==0) year = stbuilder;
            else if (iterator==1) mouth= stbuilder;
            stbuilder="";
            iterator++;
            continue;
        }
        stbuilder += dayLeft[n].textContent[i];
    }
    day =stbuilder;
}

function DaysBetween(StartDate, EndDate) {
    // The number of milliseconds in all UTC days (no DST)
    const oneDay = 1000 * 60 * 60 * 24;

    // A day in UTC always lasts 24 hours (unlike in other time formats)
    const start = Date.UTC(EndDate.getFullYear(), EndDate.getMonth(), EndDate.getDate());
    const end = Date.UTC(StartDate.getFullYear(), StartDate.getMonth(), StartDate.getDate());

    // so it's safe to divide by 24 hours
    return (start - end) / oneDay;
}