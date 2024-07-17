		FCFS
#include <stdio.h>
#include <stdlib.h>
#define MAX 20

struct process
{
    int pid, at, bt, ct, ta, wt;
};

void swap(struct process *a, struct process *b)
{
    struct process temp = *a;
    *a = *b;
    *b = temp;
}

void sort_at(struct process arr[], int n)
{
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - i - 1; j++)
        {
            if (arr[j].at > arr[j + 1].at)
                swap(&arr[j], &arr[j + 1]);
        }
}
void sort_pid(struct process arr[], int n)
{
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - i - 1; j++)
        {
            if (arr[j].pid > arr[j + 1].pid)
                swap(&arr[j], &arr[j + 1]);
        }
}
int main()
{
    int pid;
    float avwt = 0, avta = 0;

    do
    {
        printf("Enter the number of process (upto %d): ", MAX);
        scanf("%d", &pid);
    } while (pid <= 0 || pid > MAX);

    struct process fcfs[pid];

    printf("Enter process details:\n");
    for (int i = 0; i < pid; i++)
    {
        printf("\nProcessID: %d\n", i + 1);
        fcfs[i].pid = i + 1;

        printf("Arrival Time: ");
        scanf("%d", &fcfs[i].at);

        printf("Burst Time: ");
        scanf("%d", &fcfs[i].bt);
    }

    sort_at(fcfs, pid);

    int current_time = 0;

    fcfs[0].ct = 0;

    for (int i = 0; i < pid; i++)
    {
        if (current_time < fcfs[i].at)
            current_time = fcfs[i].at;

        fcfs[i].ct = current_time + fcfs[i].bt;
        fcfs[i].ta = fcfs[i].ct - fcfs[i].at;
        fcfs[i].wt = fcfs[i].ta - fcfs[i].bt;

        avwt += fcfs[i].wt;
        avta += fcfs[i].ta;

        current_time = fcfs[i].ct;
    }

    avta /= pid;
    avwt /= pid;

    sort_pid(fcfs, pid);

    printf("Process table:\n");
    printf("PID\tAT\tBT\tCT\tTA\tWT\n");
    for (int i = 0; i < pid; i++)
        printf("%d\t%d\t%d\t%d\t%d\t%d\n", fcfs[i].pid, fcfs[i].at, fcfs[i].bt, fcfs[i].ct, fcfs[i].ta, fcfs[i].wt);

    printf("Average TA: %f\n", avta);
    printf("Average WT: %f\n", avwt);

    return 0;
}





		SJF
#include <stdio.h>
#include <stdlib.h>
#define MAX 20

struct process
{
    int pid, at, bt, ct, ta, wt;
};

void swap(struct process *a, struct process *b)
{
    struct process temp = *a;
    *a = *b;
    *b = temp;
}

void sort_at(struct process arr[], int n)
{
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - i - 1; j++)
            if (arr[j].at > arr[j + 1].at)
                swap(&arr[j], &arr[j + 1]);
}

void sort_bt(struct process arr[], int n)
{
    int k = 1, min = 0, btime = 0;
    for (int i = 0; i < n; i++)
    {
        btime = btime + arr[i].bt;
        min = arr[k].bt;
        for (int j = k; j < n; j++)
            if (btime >= arr[j].at && arr[j].bt < min)
                swap(&arr[j], &arr[j - 1]);
        k++;
    }
}

void sort_pid(struct process arr[], int n)
{
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - i - 1; j++)
            if (arr[j].pid > arr[j + 1].pid)
                swap(&arr[j], &arr[j + 1]);
}

int main()
{
    int pid;
    float avta = 0, avwt = 0;

    do
    {
        printf("Enter process upto %d: ", MAX);
        scanf("%d", &pid);
    } while (pid <= 0 || pid > MAX);

    struct process sjf[pid];

    printf("Enter process details: ");
    for (int i = 0; i < pid; i++)
    {
        printf("\nProcess ID: %d", i + 1);
        sjf[i].pid = i + 1;

        printf("\nArrival Time: ");
        scanf("%d", &sjf[i].at);

        printf("Burst Time: ");
        scanf("%d", &sjf[i].bt);
    }

    sort_at(sjf, pid);
    sort_bt(sjf, pid);

    int current_time = 0;
    sjf[0].ct = 0;

    for (int i = 0; i < pid; i++)
    {
        if (current_time < sjf[i].at)
            current_time = sjf[i].at;

        sjf[i].ct = current_time + sjf[i].bt;
        sjf[i].ta = sjf[i].ct - sjf[i].at;
        sjf[i].wt = sjf[i].ta - sjf[i].bt;

        avta += sjf[i].ta;
        avwt += sjf[i].wt;

        current_time = sjf[i].ct;
    }

    avwt = avwt / pid;
    avta = avta / pid;

    sort_pid(sjf, pid);

    printf("Process table:\n");
    printf("PID\tAT\tBT\tCT\tTA\tWT\n");
    for (int i = 0; i < pid; i++)
        printf("%d\t%d\t%d\t%d\t%d\t%d\n", sjf[i].pid, sjf[i].at, sjf[i].bt, sjf[i].ct, sjf[i].ta, sjf[i].wt);

    printf("Average TA: %f\n", avta / pid);
    printf("Average WT: %f\n", avwt / pid);

    return 0;
}




		SRTF
#include <stdio.h>
#include <stdlib.h>
#define MAX 20

struct process
{
    int pid, at, bt, ct, ta, wt, rt;
};

void swap(struct process *a, struct process *b)
{
    struct process temp = *a;
    *a = *b;
    *b = temp;
}

void sort_at(struct process arr[], int n)
{
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - i - 1; j++)
            if (arr[j].at > arr[j + 1].at)
                swap(&arr[j], &arr[j + 1]);
}

void sort_pid(struct process arr[], int n)
{
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - i - 1; j++)
            if (arr[j].pid > arr[j + 1].pid)
                swap(&arr[j], &arr[j + 1]);
}

int main()
{
    int pid;
    float avwt = 0, avta = 0;

    do
    {
        printf("Enter the number of processes (up to %d): ", MAX);
        scanf("%d", &pid);
    } while (pid <= 0 || pid > MAX);

    struct process srtf[pid];

    printf("Enter process details:\n");
    for (int i = 0; i < pid; i++)
    {
        printf("\nProcessID: %d\n", i + 1);
        srtf[i].pid = i + 1;

        printf("Arrival Time: ");
        scanf("%d", &srtf[i].at);

        printf("Burst Time: ");
        scanf("%d", &srtf[i].bt);

        srtf[i].rt = srtf[i].bt;
    }

    sort_at(srtf, pid);

    int time = 0, completed = 0, short_job;

    while (completed != pid)
    {
        short_job = -1;
        for (int i = 0; i < pid; i++)
            if (srtf[i].at <= time && srtf[i].rt > 0)
                if (short_job == -1 || srtf[i].rt < srtf[short_job].rt)
                    short_job = i;

        if (short_job != -1)
        {
            srtf[short_job].rt--;
            if (srtf[short_job].rt == 0)
            {
                srtf[short_job].ct = time + 1;
                completed++;
                srtf[short_job].ta = srtf[short_job].ct - srtf[short_job].at;
                srtf[short_job].wt = srtf[short_job].ta - srtf[short_job].bt;
                avta += srtf[short_job].ta;
                avwt += srtf[short_job].wt;
            }
        }
        time++;
    }

    sort_pid(srtf, pid);

    printf("\nProcess Table:\n");
    printf("PID\tAT\tBT\tCT\tTA\tWT\n");
    for (int i = 0; i < pid; i++)
        printf("%d\t%d\t%d\t%d\t%d\t%d\n", srtf[i].pid, srtf[i].at, srtf[i].bt, srtf[i].ct, srtf[i].ta, srtf[i].wt);

    printf("Average TA: %f\n", avta / pid);
    printf("Average WT: %f\n", avwt / pid);

    return 0;
}




		RR
#include <stdio.h>
#define MAX 20

struct process
{
    int pid, at, bt, ct, ta, wt, rt;
};

void swap(struct process *a, struct process *b)
{
    struct process temp = *a;
    *a = *b;
    *b = temp;
}

void sort_at(struct process arr[], int n)
{
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - i - 1; j++)
            if (arr[j].at > arr[j + 1].at)
                swap(&arr[j], &arr[j + 1]);
}

void sort_pid(struct process arr[], int n)
{
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - i - 1; j++)
            if (arr[j].pid > arr[j + 1].pid)
                swap(&arr[j], &arr[j + 1]);
}

int main()
{
    int i, j, k, pid, tq, tct, rear, flag = 0;
    float avwt = 0, avta = 0;

    do
    {
        printf("Enter process upto %d:", MAX);
        scanf("%d", &pid);
    } while (pid <= 0 || pid > MAX);

    printf("Enter time quantum: ");
    scanf("%d", &tq);

    struct process rr[pid], temp, q[100];

    printf("Enter process details: ");
    for (int i = 0; i < pid; i++)
    {
        printf("\nProcess ID: %d", i + 1);
        rr[i].pid = i + 1;

        printf("\nArrival Time: ");
        scanf("%d", &rr[i].at);

        printf("Burst Time: ");
        scanf("%d", &rr[i].bt);

        rr[i].rt = rr[i].bt;
    }

    sort_at(rr, pid);

    tct = rr[0].at;
    i = tct + 1;
    j = 0;
    q[0] = rr[0];
    rear = 0;

    while (rear != -1)
    {
        temp = q[0];
        if (rear != 0)
            for (int m = 0; m < rear; m++)
                q[m] = q[m + 1];
        rear--;
        if (temp.rt >= tq)
        {
            tct += tq;
            temp.rt -= tq;
        }
        else
        {
            tct += temp.rt;
            temp.rt = 0;
        }
        if (temp.rt == 0)
        {
            flag = 1;
            temp.ct = tct;
        }
        if (j < pid)
        {
            for (; i <= tct; i++)
                if (rr[j + 1].at == i)
                {
                    j++;
                    rear++;
                    q[rear] = rr[j];
                }
        }
        if (flag == 0)
        {
            rear++;
            q[rear] = temp;
        }
        for (k = 0; k < pid; k++)
            if (temp.pid == rr[k].pid)
                rr[k] = temp;
        flag = 0;
    }

    sort_pid(rr, pid);

    for (i = 0; i < pid; i++)
    {
        rr[i].ta = rr[i].ct - rr[i].at;
        rr[i].wt = rr[i].ta - rr[i].bt;
        avta += rr[i].ta;
        avwt += rr[i].wt;
    }

    printf("Process table:\n");
    printf("PID\tAT\tBT\tCT\tTA\tWT\n");
    for (int i = 0; i < pid; i++)
        printf("%d\t%d\t%d\t%d\t%d\t%d\n", rr[i].pid, rr[i].at, rr[i].bt, rr[i].ct, rr[i].ta, rr[i].wt);

    printf("Average TA: %f\n", avta / pid);
    printf("Average WT: %f\n", avwt / pid);

    return 0;
}




		BANKER
#include <stdio.h>
struct pro
{
    int all[10], max[10], need[10];
    int flag;
} p[10];

int i, j, pno, r, id, k = 0, safe = 0, exec, count = 0;
int aval[10], seq[10];

void safeState()
{
    while (count != pno)
    {
        for (i = 0; i < pno; i++)
            if (p[i].flag)
            {
                exec = r;
                for (j = 0; j < r; j++)
                    if (p[i].need[j] > aval[j])
                        exec = 0;
                if (exec == r)
                {
                    for (j = 0; j < r; j++)
                        aval[j] += p[i].all[j];
                    p[i].flag = 0;
                    seq[k++] = i;
                    safe = 1;
                    count++;
                }
            }
        if (!safe)
        {
            printf("System is in Unsafe State\n");
            break;
        }
    }
    if (safe)
    {
        printf("System is in Safe State. Safe Sequence: ");
        for (i = 0; i < pno; i++)
            printf("P[%d] \t", seq[i]);
        printf("\n");
    }
}

int main()
{
    printf("Enter number of process: ");
    scanf("%d", &pno);

    printf("Enter number of resources: ");
    scanf("%d", &r);

    printf("Enter Available resources of each type: ");
    for (j = 0; j < r; j++)
        scanf("%d", &aval[j]);

    printf("Enter Process Details:");
    for (i = 0; i < pno; i++)
    {
        printf("\nProcess %d\n", i);
        printf("Allocation Matrix:\t");
        for (j = 0; j < r; j++)
            scanf("%d", &p[i].all[j]);

        printf("Maximum Matrix:\t\t");
        for (j = 0; j < r; j++)
            scanf("%d", &p[i].max[j]);

        p[i].flag = 1;
        for (j = 0; j < r; j++)
            p[i].need[j] = p[i].max[j] - p[i].all[j];
    }

    printf("\nProcess Details\n");
    printf("PID\t\tAllocation\t\tMax\t\tNeed\n");
    for (i = 0; i < pno; i++)
    {
        printf("%d\t\t", i);
        for (j = 0; j < r; j++)
            printf("%d   ", p[i].all[j]);
        printf("\t\t");
        for (j = 0; j < r; j++)
            printf("%d   ", p[i].max[j]);
        printf("\t\t");
        for (j = 0; j < r; j++)
            printf("%d   ", p[i].need[j]);
        printf("\n");
    }

    safeState();
    return 0;
}



		PRODUCER CONSUMER
#include <stdio.h>
#include <stdlib.h>
int mutex = 1, full = 0, empty = 3, x = 0;
void main()
{
    int n;
    void producer();
    void consumer();
    int wait(int);
    int signal(int);
    printf("\n1.PRODUCER\t2.CONSUMER\t3.EXIT");
    while (1)
    {
        printf("\nChoice: ");
        scanf("%d", &n);
        switch (n)
        {
        case 1:
            if ((mutex == 1) && (empty != 0))
                producer();
            else
                printf("BUFFER IS FULL");
            break;
        case 2:
            if ((mutex == 1) && (full != 0))
                consumer();
            else
                printf("BUFFER IS EMPTY");
            break;
        case 3:
            exit(0);
            break;
        }
    }
}
int wait(int x)
{
    return (--x);
}
int signal(int x)
{
    return (++x);
}
void producer()
{
    mutex = wait(mutex);
    full = signal(full);
    empty = wait(empty);
    x++;
    printf("\nproducer produces the item %d", x);
    mutex = signal(mutex);
}
void consumer()
{
    mutex = wait(mutex);
    full = wait(full);
    empty = signal(empty);
    printf("\n consumer consumes item%d", x);
    x--;
    mutex = signal(mutex);
}




		LRU
#include <stdio.h>
int main() {
    int pages[100], n, capacity, frame[10], page_faults = 0, frame_index = 0, page_age[10];
    printf("Enter the number of pages: ");
    scanf("%d", &n);
    printf("Enter the reference string (RS): ");
    for (int i = 0; i < n; i++)
        scanf("%d", &pages[i]);
    printf("Enter the capacity of frames: ");
    scanf("%d", &capacity);
    for (int i = 0; i < capacity; i++) {
        frame[i] = -1;
        page_age[i] = 0;
    }
    for (int i = 0; i < n; i++) {
        int page_found = 0;
        for (int j = 0; j < capacity; j++)
            if (frame[j] == pages[i]) {
                page_found = 1;
                page_age[j] = i + 1;
                break;
            }
        if (!page_found) {
            int lru_index = 0, min_age = page_age[0];
            for (int j = 1; j < capacity; j++) {
                if (page_age[j] < min_age) {
                    lru_index = j;
                    min_age = page_age[j];
                }
            }
            frame[lru_index] = pages[i];
            page_age[lru_index] = i + 1;
            page_faults++;
        }
        printf("RS: %d |: ", pages[i]);
        for (int j = 0; j < capacity; j++) {
            if (frame[j] == -1)
                printf(" _");
            else
                printf(" %d", frame[j]);
        }
        printf("\n");
    }
    printf("Page faults: %d\n", page_faults);
    printf("Page Hits: %d\n", n-page_faults);
    printf("Page Fault Ratio: %d\n", page_faults*100/n);
    printf("Page Hit Ratio: %d", (n-page_faults)*100/n);
    return 0;
}




		BEST FIT
#include <stdio.h>
#define MAX 10
int main()
{
    int bsize[MAX], psize[MAX], pno, bno, temp, low;
    static int flag[MAX], allocation[MAX];
    printf("Enter no. of blocks: ");
    scanf("%d", &bno);
    printf("Enter size of each block:\t");
    for (int i = 0; i < bno; i++)
        scanf("%d", &bsize[i]);
    printf("Enter no. of process: ");
    scanf("%d", &pno);
    printf("Enter size of each process:\t");
    for (int i = 0; i < pno; i++)
        scanf("%d", &psize[i]);
    printf("\nProcess No.\tSize\t\tBlock No\tSize\t\tRemaining\n");
    for (int i = 0; i < pno; i++)
    {
        low = 10000;
        allocation[i] = -1;
        for (int j = 0; j < bno; j++)
            if (flag[j] != 1)
            {
                temp = bsize[j] - psize[i];
                if (temp >= 0 && temp < low)
                {
                    allocation[i] = j;
                    low = temp;
                }
            }
        if (allocation[i] != -1)
        {
            printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\n", i + 1, psize[i], allocation[i] + 1, bsize[allocation[i]], low);
            flag[allocation[i]] = 1;
        }
    }
    return 0;
}
