const canvas = document.querySelector('#game-canvas');
const ctx = canvas.getContext("2d");

const CANVAS_WIDTH = 900;
const CANVAS_HEIGHT = 600;

const FPS = 30;

const ballRadius = 10;
let ballX = CANVAS_WIDTH / 2 - ballRadius;
let ballY = CANVAS_HEIGHT / 2 - ballRadius;
let Xvel = 10;
let Yvel = 5;

const PADDLE_HEIGHT = 150;
const PADDLE_WIDTH = 10;
let PADDLE1_Y = (CANVAS_HEIGHT / 2 - PADDLE_HEIGHT / 2);
let PADDLE2_Y = (CANVAS_HEIGHT / 2 - PADDLE_HEIGHT / 2);

let mouse = { x: 0, y: 0 };

const drawLine = () => {
    for(let i=0; i<=CANVAS_HEIGHT; i+=40) {
        ctx.fillStyle = "white";
        ctx.fillRect(CANVAS_WIDTH/2-3,i,6,20);
    }
}

canvas.addEventListener("mousemove", event => {
    mouse.x = event.offsetX;
    mouse.y = event.offsetY;
})


window.onload = () => {

    setInterval(() => {
        ctx.fillStyle = "rgba(0,0,0,0.8)";
        ctx.fillRect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
        draw();
        update();
    }, 1000 / FPS);

}

const draw = () => {
    //draw the ball
    ctx.fillStyle = "white";
    ctx.beginPath();
    ctx.arc(ballX, ballY, ballRadius, 0, Math.PI * 2, true);
    ctx.fill();

    //draw Paddle1
    ctx.fillRect(0,PADDLE1_Y, PADDLE_WIDTH, PADDLE_HEIGHT);


    //draw Paddle2
    ctx.fillRect((CANVAS_WIDTH - PADDLE_WIDTH),PADDLE2_Y,
        PADDLE_WIDTH, PADDLE_HEIGHT);

    drawLine();
}

const update = () => {
    //move the ball 
    ballX += Xvel;
    ballY += Yvel;

    //check wall bounce
    if ((ballY - ballRadius) < 0 || (ballY + ballRadius) > CANVAS_HEIGHT) {
        Yvel = -Yvel;
    }
    //check paddle bounce
    if ((ballY > PADDLE1_Y && ballY < (PADDLE1_Y + PADDLE_HEIGHT) && (ballX-ballRadius-PADDLE_WIDTH<0))
        || ((ballY > PADDLE2_Y && ballY < (PADDLE2_Y + PADDLE_HEIGHT))) && (ballX+ballRadius+PADDLE_WIDTH>CANVAS_WIDTH)) {
        Xvel = -Xvel;
    }

    //move paddle
    if(mouse.x<CANVAS_WIDTH/2) {
        PADDLE1_Y = mouse.y - PADDLE_HEIGHT/2;
    }
    if(mouse.x>CANVAS_WIDTH/2) {
        PADDLE2_Y = mouse.y - PADDLE_HEIGHT/2;
    }

    //check miss 
    if((ballX+ballRadius>CANVAS_WIDTH) || (ballX-ballRadius<0)) {
        ballX = CANVAS_WIDTH / 2 - ballRadius;
        ballY = CANVAS_HEIGHT / 2 - ballRadius;
    }
}
