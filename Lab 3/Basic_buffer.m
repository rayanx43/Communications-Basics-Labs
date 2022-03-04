int samples[16];
unsigned int head=0;
unsigned int tail=0;
void put_sample(int samp1)
{
 /* Put a sample at the tail of the buffer */
 samples[tail] = samp1;
 
/* Increment. By masking bits, make modulo 16 */
 tail = (tail + 1) & 15;
}
int get_sample()
{
 int samp1;
 /* Get a sample from head of buffer. */
 samp1 = samples[head];
 /* Increment to next value */
 head = (head + 1) & 15;
}
 