const canvas = document.getElementById("game-canvas");
canvas.width = "288"; canvas.height = "512";
const ctx = canvas.getContext("2d");


const bird = new Image();
const fg = new Image();
const bg = new Image();
const pole1 = new Image();
const pole2 = new Image();

pole1.src = "assets/pipe-up.png";
pole2.src = "assets/pipe-down.png";
bg.src = "assets/bg.png";
fg.src = "assets/fg.png";
bird.src = "assets/bird.png";

const FPS = 30;
const gap = 120;


const pole = [];

pole[0] = {
    x: canvas.width,
    y: -100
}

let fallSpeed = 3;
let birdX = 100;
let birdY = 100;
let score = 0;

let keydown = false;


window.addEventListener("keydown", () => {
    keydown = true;
})
window.addEventListener("keyup", () => {
    keydown = false;
})

window.onload = () => {
    setInterval(() => {
        draw();
        update();
    }
        , 1000 / FPS);

}

const draw = () => {
    ctx.drawImage(bg, 0, 0);
    generatePole(pole);
    ctx.drawImage(fg, 0, bg.height - fg.height);
    ctx.drawImage(bird, birdX, birdY);
    ctx.fillStyle = "#000";
    ctx.font = "20px Verdana";
    ctx.fillText("Score : "+score,10,canvas.height-20);
}

const update = () => {
    //gravity
    birdY += fallSpeed;
    if(keydown) {
        birdY -= fallSpeed*2
    }
}

const generatePole = pole => {
    for(let i=0; i<pole.length; i++) {
        ctx.drawImage(pole1, pole[i].x, pole[i].y);
        ctx.drawImage(pole2, pole[i].x, pole[i].y + gap + pole1.height);
        pole[i].x--;
        if(pole[i].x == 100) {
            pole.push({
                x: canvas.width,
                y: -Math.floor(Math.random()*pole1.height) + 20
            })
        }
        if( ((birdX + bird.width >= pole[i].x) && (birdX <= pole[i].x + pole1.width) 
        && ((birdY <= pole[i].y + pole1.height) || (birdY+bird.height >= pole[i].y+pole1.height+gap))) 
        || ((birdY + bird.height)>= (canvas.height - fg.height))) {
            location.reload();
        }
        if(pole[i].x == 50){
            score++;
        }

    }
}
