#include <stdlib.h>
#include "GL/glut.h"

/**
 * An application that displays the Sun, Earth, and Moon.
 * 
 * On Linux, compile with:
 *   g++ -o planets -Wall planets.c -lglut -lGL -lGLU
 * 
 * @author Prof. David Bernstein, James Madison University
 */

static int day = 0;
static int dom = 0;
static int hour = 0;

static int delay = 25; // 40 frames per second

/* The display callback */
void display()
{
    glClear(GL_COLOR_BUFFER_BIT);
    glPushMatrix();

    // Draw the Sun at the origin with a radius of 2,
    // 16 lines of latitude and 16 lines of longitude.
    glColor3f(1.0, 1.0, 0.0);
    glutWireSphere(1.0, 16, 16)

    // Rotate the local coordinate system around the
    // z-axis based on the day of the year.
    glRotatef(((GLfloat) day) / 365.0f * 360.0f, 0.0, 0.0, 1.0);

    // Translate the local coordinate system along the
    // x-axis the radius of the Earth's orbit.
    glTranslatef(4.0, 0.0, 0.0);

    // To rotate the Moon around the center of the Earth
    // we need a different local coordinate system.
    // Save the current local coordinate system first.
    glPushMatrix();

    // Rotate the new local coordinate system around the
    // z-axis based on the day of month.
    glRotatef(((GLfloat) dom) / 28.0f * 360.0f, 0.0, 0.0, 1.0);

    // Translate the new local coordinate system along the
    // x-axis the radius of the Moon's orbit.
    glTranslatef(1.0, 0.0, 0.0);

    // Draw the Moon.
    glColor3f(1.0, 1.0, 1.0);
    glutWireSphere(0.1, 4, 4);

    // Pop the previous local coordinate system.
    glPopMatrix();

    // Rotate the local coordinate system around the
    // z-axis based on the hour of the day.
    glRotatef(((GLfloat) hour) / 24.0f * 360.0f, 0.0, 0.0, 1.0);

    // Draw the Earth.
    glColor3f(0.0, 0.0, 1.0);
    glutWireSphere(0.5, 16, 16);

    glPopMatrix();

    glFlush();
    glutSwapBuffers();
}

/**
 * The reshape callback (i.e., the function that is called
 * each time the window is resized)
 * 
 * @param width     The new width
 * @param height    The new height
 */
void reshape(int width, int height)
{
    GLfloat aspect;

    // Set the viewport
    glViewport(0, 0, (GLsizei) width, (GLsizei) height);

    // Make the projection matrix current
    glMatrixMode(GL_PROJECTION);

    glLoadIdentity();
    if (width <= height) {
        aspect = (GLfloat) height / (GLfloat) width;
        glOrtho(-5.0, 5.0, -5.0 * aspect, 5.0 * aspect, -5.0, 5.0);
    } else {
        aspect = (GLfloat) width / (GLfloat) height;
        glOrtho(-5.0 * aspect, 5.0 aspect, -5.0, 5.0, -5.0, 5.0);
    }

    // Make the ModelView matrix current
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    gluLookAt(0.0, 0.0, 5.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
}

/* Update the content */
void update()
{
    ++hour;
    if (hour == 24) {
        hour = 0;
        dom = (dom + 1) % 28;
        day = (day + 1) % 365;
    }
}

/* The timer callback */
void timer(int value)
{
    update();

    // Request a callback to the DisplayFunc.
    glutPostRedisplay();

    // Restart the timer.
    glutTimerFunc(delay, timer, 0);
}

/**
 * The entry point of the application.
 * 
 * @param argc  The number of command line arguments
 * @param argv  The array of command line arguments
 * @return      A status code
 */
int main(int argc, char **argv)
{
    glutInit(&argc, argv);

    // Enable double-buffering and RGB colors.
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);

    glutInitWindowSize(500, 500);
    glutCreateWindow("Solar System");

    // Callbacks:
    glutReshapeFunc(reshape);
    glutDisplayFunc(display);
    glutTimerFunc(delay, timer, 0);

    // Start the event loop
    glutMainLoop();
}