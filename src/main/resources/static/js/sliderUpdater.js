function updateTempSlider(value, elementID)
{
    value = parseInt(value).toFixed(1).toString();
    elementID.textContent = value;
    elementID.style.color = "rgb("+(20+(value*4.2))+",0,"+(180-(value*4.2))+")";
}
function updateHumiSlider(value, elementID)
{
    elementID.textContent = value;
    elementID.style.color = "rgb(0,0,"+(50+(value*2))+")";
}
function updateLightSlider(value, elementID)
{
    if(value == "0")
    {
        elementID.textContent = "X";
        elementID.style.color = "blue";
    }
    else
    {
        elementID.textContent = "O";
        elementID.style.color = "orange";
    }
}