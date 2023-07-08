#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <time.h>
#include <sys/wait.h>
#include <semaphore.h>
#include <fcntl.h>

#define SLEEP 0.1
#define NO_OF_PROCESS 3
#define NO_OF_ITERATION 10

char * uitoa(int num){
    char * str;
    str = (char *)malloc(5 * sizeof(char));
    str[4] = 0;
    for (int i = 3; i >= 0; i--){
        str[i] = (num%10)+'0';
        num/=10;
    }
    return str;
}

int main(int argc, char const *argv[])
{

    int parent_pid = getpid();
    pid_t *child = (pid_t *)malloc(NO_OF_PROCESS * sizeof(pid_t));

    sem_t ***sem = (sem_t ***)malloc(NO_OF_PROCESS * sizeof(sem_t**));
    for (int i = 0; i < NO_OF_PROCESS; i++){
        sem[i] = (sem_t **)malloc(NO_OF_ITERATION * sizeof(sem_t *));
        for (int j = 0; j < NO_OF_ITERATION; j++){
            char * pcnt = uitoa(i);
            char * itcnt = uitoa(j);
            sem[i][j] = sem_open(strcat(pcnt, itcnt), O_CREAT, 0660, -2);
            free(pcnt);
            free(itcnt);
        }
    }

    
    for (int i = 0; i < NO_OF_PROCESS; i++){
        child[i] = fork();
        if (child[i] < 0) {
            //error
            printf("Forking failed\n");
            printf("Child no: %d", i);
            return 1;
        } else if (child[i] == 0){
            /**
             * @brief 
             * child -> 
             * do the loop here
             * 10 iterations
             */
            srand(getpid());
            for (int j = 0; j < 10; j++){
                if(j!=0){
                    sem_wait(sem[0][j-1]);}
                    sleep(rand()%10);
                printf("Process ID: %d\tParent PID: %d\tIteration count: %d\n", i, getppid(), j);
                sem_post(sem[0][j]);
            }
            break;


        } else {
            /**
             * @brief 
             * parent ->
             * print details
             */
            printf("Child process: %d, pid: %d \n", i, child[i]); 
        }
    }


    if (getpid() == parent_pid){
        int v;
        for (int i = 0; i < 2; i++){
            waitpid(child[i], &v, 0);
        }
        free(child);

        for (int i = 0; i < NO_OF_PROCESS-1; i++){
            for (int j = 0; j < NO_OF_ITERATION; j++){
                char * pcnt = uitoa(i);
                char * itcnt = uitoa(j);
                sem_unlink(strcat(pcnt, itcnt));
                free(pcnt);
                free(itcnt);
            }
            free(sem[i]);
        }
    }
    return 0;
}
