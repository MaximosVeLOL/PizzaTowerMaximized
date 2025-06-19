if (!isStatic)
{
    velocity[1] += mass;
    x += velocity[0];
    y += velocity[1];
    image_angle += sign(x - xstart);
}
else
{
    lifetime--;
    
    if (lifetime <= 0)
        instance_destroy();
}
