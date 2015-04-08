From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: how to get relayd pid
Date: Wed, 8 Apr 2015 19:12:52 +0530
Message-ID: <CAM5kDqzMYxk=Fv9UBgyQ0xvfMiubos5-+W7NXh3CYtEYoVDScQ__5099.92500669814$1428500635$gmane$org@mail.gmail.com>
References: <CAM5kDqwUjPcRd4sn3tBtoA0rmuwNh+U87G9VoXq=cR=wJvJS_g@mail.gmail.com>
 <CAB4xu_19L8FqJWtHotni3SVJ6MfDo_3mZgv7uWYQiZqENTagcQ@mail.gmail.com>
 <CAM5kDqz1dkyV3R4_XRYdbBUjUB6z0ySbGNAS9faRwerroHDriA@mail.gmail.com>
 <CAB4xu_34Ni=q9dYzQ=PXpjoyk2Qz04ZUPdB3=yYRiTR7TyXMHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1793473505=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YfqFt-00069D-Rt
 for lttng-dev@lists.lttng.org; Wed, 08 Apr 2015 09:43:00 -0400
Received: by wiaa2 with SMTP id a2so59121716wia.0
 for <lttng-dev@lists.lttng.org>; Wed, 08 Apr 2015 06:42:52 -0700 (PDT)
In-Reply-To: <CAB4xu_34Ni=q9dYzQ=PXpjoyk2Qz04ZUPdB3=yYRiTR7TyXMHg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1793473505==
Content-Type: multipart/alternative; boundary=f46d044282882b173e051336b52a

--f46d044282882b173e051336b52a
Content-Type: text/plain; charset=UTF-8

Phil,
Thanks a lot for the code

Anand Neeli

On Wed, Apr 8, 2015 at 2:05 AM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> Anand,
>
> On Tue, Apr 7, 2015 at 4:19 PM, Anand Neeli <anand.neeli@gmail.com> wrote:
> > For C
>
> lttng-relayd does not write its PID to a file.
>
> For C, here's the programmatic way of getting the PID of the first
> lttng-relayd process found (inspired by [1]):
>
>     #include <stdlib.h>
>     #include <stdio.h>
>     #include <string.h>
>     #include <dirent.h>
>
>     /* checks if the string is purely an integer
>      * we can do it with `strtol' also
>      */
>     int check_if_number (char *str)
>     {
>       int i;
>       for (i=0; str[i] != '\0'; i++)
>       {
>         if (!isdigit (str[i]))
>         {
>           return 0;
>         }
>       }
>       return 1;
>     }
>
>     #define MAX_BUF 1024
>     #define PID_LIST_BLOCK 32
>
>     int *pidof (char *pname)
>     {
>       DIR *dirp;
>       FILE *fp;
>       struct dirent *entry;
>       int *pidlist, pidlist_index = 0, pidlist_realloc_count = 1;
>       char path[MAX_BUF], read_buf[MAX_BUF];
>
>       dirp = opendir ("/proc/");
>       if (dirp == NULL)
>       {
>         perror ("Fail");
>         return NULL;
>       }
>
>       pidlist = malloc (sizeof (int) * PID_LIST_BLOCK);
>       if (pidlist == NULL)
>       {
>         return NULL;
>       }
>
>       while ((entry = readdir (dirp)) != NULL)
>       {
>         if (check_if_number (entry->d_name))
>         {
>           strcpy (path, "/proc/");
>           strcat (path, entry->d_name);
>           strcat (path, "/comm");
>
>           /* A file may not exist, it may have been removed.
>            * dut to termination of the process. Actually we need to
>            * make sure the error is actually file does not exist to
>            * be accurate.
>            */
>           fp = fopen (path, "r");
>           if (fp != NULL)
>           {
>             fscanf (fp, "%s", read_buf);
>             if (strcmp (read_buf, pname) == 0)
>             {
>               /* add to list and expand list if needed */
>               pidlist[pidlist_index++] = atoi (entry->d_name);
>               if (pidlist_index == PID_LIST_BLOCK * pidlist_realloc_count)
>               {
>                 pidlist_realloc_count++;
>                 pidlist = realloc (pidlist, sizeof (int) *
> PID_LIST_BLOCK * pidlist_realloc_count); //Error check todo
>                 if (pidlist == NULL)
>                 {
>                   return NULL;
>                 }
>               }
>             }
>             fclose (fp);
>           }
>         }
>       }
>
>
>       closedir (dirp);
>       pidlist[pidlist_index] = -1; /* indicates end of list */
>       return pidlist;
>     }
>
>     int main (void)
>     {
>       int *list = pidof("lttng-relayd");
>
>       if (!list || list[0] == -1) {
>         fprintf(stderr, "lttng-relayd is not running!\n");
>         free(list);
>         return 1;
>       }
>
>       printf("PID of first lttng-relayd found: %d\n", list[0]);
>       free(list);
>
>       return 0;
>     }
>
> [1]
> http://phoxis.org/2013/09/13/find-process-ids-of-a-running-process-by-name/
>
> Hope it helps,
> Phil
>
> >
> >
> >
> >
> > On Wed, Apr 8, 2015 at 1:45 AM, Philippe Proulx <eeppeliteloop@gmail.com
> >
> > wrote:
> >>
> >> Anand,
> >>
> >> On Tue, Apr 7, 2015 at 4:07 PM, Anand Neeli <anand.neeli@gmail.com>
> wrote:
> >> >
> >> > Hi All,
> >> > Is there any better way of getting lttng-relayd PID programmatically?
> >> >
> >> > like sessiond pid is in /var/run/lttng/lttng-sessiond.pid,  is there
> any
> >> > similar way to get relayd PID?
> >>
> >> For which language?
> >>
> >> Phil
> >> >
> >> >
> >> > Thanks,
> >> > Anand Neeli
> >> >
> >> > _______________________________________________
> >> > lttng-dev mailing list
> >> > lttng-dev@lists.lttng.org
> >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >> >
> >
> >
>

--f46d044282882b173e051336b52a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Phil,<div>Thanks a lot for the code</div><div><br></div><d=
iv>Anand Neeli</div></div><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On Wed, Apr 8, 2015 at 2:05 AM, Philippe Proulx <span dir=3D"ltr">=
&lt;<a href=3D"mailto:eeppeliteloop@gmail.com" target=3D"_blank">eeppelitel=
oop@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Anand=
,<br>
<br>
On Tue, Apr 7, 2015 at 4:19 PM, Anand Neeli &lt;<a href=3D"mailto:anand.nee=
li@gmail.com">anand.neeli@gmail.com</a>&gt; wrote:<br>
&gt; For C<br>
<br>
lttng-relayd does not write its PID to a file.<br>
<br>
For C, here&#39;s the programmatic way of getting the PID of the first<br>
lttng-relayd process found (inspired by [1]):<br>
<br>
=C2=A0 =C2=A0 #include &lt;stdlib.h&gt;<br>
=C2=A0 =C2=A0 #include &lt;stdio.h&gt;<br>
=C2=A0 =C2=A0 #include &lt;string.h&gt;<br>
=C2=A0 =C2=A0 #include &lt;dirent.h&gt;<br>
<br>
=C2=A0 =C2=A0 /* checks if the string is purely an integer<br>
=C2=A0 =C2=A0 =C2=A0* we can do it with `strtol&#39; also<br>
=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 int check_if_number (char *str)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 int i;<br>
=C2=A0 =C2=A0 =C2=A0 for (i=3D0; str[i] !=3D &#39;\0&#39;; i++)<br>
=C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!isdigit (str[i]))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 return 1;<br>
=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 #define MAX_BUF 1024<br>
=C2=A0 =C2=A0 #define PID_LIST_BLOCK 32<br>
<br>
=C2=A0 =C2=A0 int *pidof (char *pname)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 DIR *dirp;<br>
=C2=A0 =C2=A0 =C2=A0 FILE *fp;<br>
=C2=A0 =C2=A0 =C2=A0 struct dirent *entry;<br>
=C2=A0 =C2=A0 =C2=A0 int *pidlist, pidlist_index =3D 0, pidlist_realloc_cou=
nt =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 char path[MAX_BUF], read_buf[MAX_BUF];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 dirp =3D opendir (&quot;/proc/&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 if (dirp =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror (&quot;Fail&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 pidlist =3D malloc (sizeof (int) * PID_LIST_BLOCK);<br=
>
=C2=A0 =C2=A0 =C2=A0 if (pidlist =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 while ((entry =3D readdir (dirp)) !=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (check_if_number (entry-&gt;d_name))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strcpy (path, &quot;/proc/&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strcat (path, entry-&gt;d_name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strcat (path, &quot;/comm&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* A file may not exist, it may have bee=
n removed.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* dut to termination of the proces=
s. Actually we need to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* make sure the error is actually =
file does not exist to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* be accurate.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp =3D fopen (path, &quot;r&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp !=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fscanf (fp, &quot;%s&quot;, read_=
buf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp (read_buf, pname) =3D=
=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* add to list and expand =
list if needed */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pidlist[pidlist_index++] =
=3D atoi (entry-&gt;d_name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pidlist_index =3D=3D P=
ID_LIST_BLOCK * pidlist_realloc_count)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pidlist_realloc_cou=
nt++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pidlist =3D realloc=
 (pidlist, sizeof (int) *<br>
PID_LIST_BLOCK * pidlist_realloc_count); //Error check todo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pidlist =3D=3D =
NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose (fp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 closedir (dirp);<br>
=C2=A0 =C2=A0 =C2=A0 pidlist[pidlist_index] =3D -1; /* indicates end of lis=
t */<br>
=C2=A0 =C2=A0 =C2=A0 return pidlist;<br>
=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 int main (void)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 int *list =3D pidof(&quot;lttng-relayd&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 if (!list || list[0] =3D=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;lttng-relayd is not runni=
ng!\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(list);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 printf(&quot;PID of first lttng-relayd found: %d\n&quo=
t;, list[0]);<br>
=C2=A0 =C2=A0 =C2=A0 free(list);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 }<br>
<br>
[1] <a href=3D"http://phoxis.org/2013/09/13/find-process-ids-of-a-running-p=
rocess-by-name/" target=3D"_blank">http://phoxis.org/2013/09/13/find-proces=
s-ids-of-a-running-process-by-name/</a><br>
<br>
Hope it helps,<br>
Phil<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Apr 8, 2015 at 1:45 AM, Philippe Proulx &lt;<a href=3D"mailto:=
eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Anand,<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Apr 7, 2015 at 4:07 PM, Anand Neeli &lt;<a href=3D"mailto:=
anand.neeli@gmail.com">anand.neeli@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi All,<br>
&gt;&gt; &gt; Is there any better way of getting lttng-relayd PID programma=
tically?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; like sessiond pid is in /var/run/lttng/lttng-sessiond.pid,=C2=
=A0 is there any<br>
&gt;&gt; &gt; similar way to get relayd PID?<br>
&gt;&gt;<br>
&gt;&gt; For which language?<br>
&gt;&gt;<br>
&gt;&gt; Phil<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks,<br>
&gt;&gt; &gt; Anand Neeli<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; _______________________________________________<br>
&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.=
lttng.org</a><br>
&gt;&gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/=
lttng-dev</a><br>
&gt;&gt; &gt;<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div>

--f46d044282882b173e051336b52a--


--===============1793473505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1793473505==--
