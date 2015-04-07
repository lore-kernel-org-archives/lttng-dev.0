From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: how to get relayd pid
Date: Tue, 7 Apr 2015 16:35:32 -0400
Message-ID: <CAB4xu_34Ni=q9dYzQ=PXpjoyk2Qz04ZUPdB3=yYRiTR7TyXMHg__23757.7948406853$1428439025$gmane$org@mail.gmail.com>
References: <CAM5kDqwUjPcRd4sn3tBtoA0rmuwNh+U87G9VoXq=cR=wJvJS_g@mail.gmail.com>
 <CAB4xu_19L8FqJWtHotni3SVJ6MfDo_3mZgv7uWYQiZqENTagcQ@mail.gmail.com>
 <CAM5kDqz1dkyV3R4_XRYdbBUjUB6z0ySbGNAS9faRwerroHDriA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1YfaEC-0000t9-Oq
 for lttng-dev@lists.lttng.org; Tue, 07 Apr 2015 16:36:10 -0400
Received: by lbbqq2 with SMTP id qq2so43271327lbb.3
 for <lttng-dev@lists.lttng.org>; Tue, 07 Apr 2015 13:36:03 -0700 (PDT)
In-Reply-To: <CAM5kDqz1dkyV3R4_XRYdbBUjUB6z0ySbGNAS9faRwerroHDriA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Anand,

On Tue, Apr 7, 2015 at 4:19 PM, Anand Neeli <anand.neeli@gmail.com> wrote:
> For C

lttng-relayd does not write its PID to a file.

For C, here's the programmatic way of getting the PID of the first
lttng-relayd process found (inspired by [1]):

    #include <stdlib.h>
    #include <stdio.h>
    #include <string.h>
    #include <dirent.h>

    /* checks if the string is purely an integer
     * we can do it with `strtol' also
     */
    int check_if_number (char *str)
    {
      int i;
      for (i=0; str[i] != '\0'; i++)
      {
        if (!isdigit (str[i]))
        {
          return 0;
        }
      }
      return 1;
    }

    #define MAX_BUF 1024
    #define PID_LIST_BLOCK 32

    int *pidof (char *pname)
    {
      DIR *dirp;
      FILE *fp;
      struct dirent *entry;
      int *pidlist, pidlist_index = 0, pidlist_realloc_count = 1;
      char path[MAX_BUF], read_buf[MAX_BUF];

      dirp = opendir ("/proc/");
      if (dirp == NULL)
      {
        perror ("Fail");
        return NULL;
      }

      pidlist = malloc (sizeof (int) * PID_LIST_BLOCK);
      if (pidlist == NULL)
      {
        return NULL;
      }

      while ((entry = readdir (dirp)) != NULL)
      {
        if (check_if_number (entry->d_name))
        {
          strcpy (path, "/proc/");
          strcat (path, entry->d_name);
          strcat (path, "/comm");

          /* A file may not exist, it may have been removed.
           * dut to termination of the process. Actually we need to
           * make sure the error is actually file does not exist to
           * be accurate.
           */
          fp = fopen (path, "r");
          if (fp != NULL)
          {
            fscanf (fp, "%s", read_buf);
            if (strcmp (read_buf, pname) == 0)
            {
              /* add to list and expand list if needed */
              pidlist[pidlist_index++] = atoi (entry->d_name);
              if (pidlist_index == PID_LIST_BLOCK * pidlist_realloc_count)
              {
                pidlist_realloc_count++;
                pidlist = realloc (pidlist, sizeof (int) *
PID_LIST_BLOCK * pidlist_realloc_count); //Error check todo
                if (pidlist == NULL)
                {
                  return NULL;
                }
              }
            }
            fclose (fp);
          }
        }
      }


      closedir (dirp);
      pidlist[pidlist_index] = -1; /* indicates end of list */
      return pidlist;
    }

    int main (void)
    {
      int *list = pidof("lttng-relayd");

      if (!list || list[0] == -1) {
        fprintf(stderr, "lttng-relayd is not running!\n");
        free(list);
        return 1;
      }

      printf("PID of first lttng-relayd found: %d\n", list[0]);
      free(list);

      return 0;
    }

[1] http://phoxis.org/2013/09/13/find-process-ids-of-a-running-process-by-name/

Hope it helps,
Phil

>
>
>
>
> On Wed, Apr 8, 2015 at 1:45 AM, Philippe Proulx <eeppeliteloop@gmail.com>
> wrote:
>>
>> Anand,
>>
>> On Tue, Apr 7, 2015 at 4:07 PM, Anand Neeli <anand.neeli@gmail.com> wrote:
>> >
>> > Hi All,
>> > Is there any better way of getting lttng-relayd PID programmatically?
>> >
>> > like sessiond pid is in /var/run/lttng/lttng-sessiond.pid,  is there any
>> > similar way to get relayd PID?
>>
>> For which language?
>>
>> Phil
>> >
>> >
>> > Thanks,
>> > Anand Neeli
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >
>
>
