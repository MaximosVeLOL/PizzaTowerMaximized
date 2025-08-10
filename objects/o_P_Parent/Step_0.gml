if (canMove)
{
    velocity[1] += mass;
    x += velocity[0];
    y += velocity[1];
    image_angle += x - xprevious;
}