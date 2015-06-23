From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng list -u return "Error: Command error"
Date: Wed, 24 Jun 2015 00:03:12 +0200
Message-ID: <CA+jJMxv_NK10R_hovxLYk4i3pZDQhsWivgyS_q3k_+dN6XXJyg__46923.6624696807$1435097083$gmane$org@mail.gmail.com>
References: <---.GY------rzHGY$b39120f9-2664-4e5c-bb89-379e7494cb0d@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0829362644=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Z7WHm-0008I7-9U
 for lttng-dev@lists.lttng.org; Tue, 23 Jun 2015 18:03:28 -0400
Received: by pdcu2 with SMTP id u2so15725682pdc.3
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jun 2015 15:03:12 -0700 (PDT)
In-Reply-To: <---.GY------rzHGY$b39120f9-2664-4e5c-bb89-379e7494cb0d@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0829362644==
Content-Type: multipart/alternative; boundary=047d7b15fcb7743c870519368e09

--047d7b15fcb7743c870519368e09
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2015 at 5:00 AM, zhenyu.ren <zhenyu.ren@aliyun.com> wrote:

> Hi,dev-team
>
>    As the subject is my problem. It seems that the function
> get_cmdline_by_pid() will fail if kernel.pid_max > 100000 (i.e. 131072)
>
> static char *get_cmdline_by_pid(pid_t pid)
> {
>         int ret;
>         FILE *fp =3D NULL;
>         char *cmdline =3D NULL;
>         char path[20];        /* Can't go bigger than /proc/65535/cmdline
> */
>
>
>  I think path[20] is not big enough .Do you have any better idea?
>

Good catch! Sorry for the delay, traveling has caused me to fall behind on
e-mails... Catching up!

Based on PROC(5):

       /proc/sys/kernel/pid_max (since Linux 2.5.34)
              This  file  specifies the value at which PIDs wrap around
              (i.e., the value in this file is  one  greater  than  the
              maximum PID).  PIDs greater than this value are not allo=E2=
=80=90
              cated; thus, the value in this file also acts as  a  sys=E2=
=80=90
              tem-wide  limit  on  the  total  number  of processes and
              threads.  The default value for this file, 32768, results
              in  the  same  range  of  PIDs as on earlier kernels.  On
              32-bit platforms, 32768 is the maximum value for pid_max.
              On  64-bit systems, pid_max can be set to any value up to
              2^22 (PID_MAX_LIMIT, approximately 4 million).

I have introduced a fix in master, stable-2.6 and stable-2.5.

commit fae9a062a468c47fc71ef7aa96374bf9d87d137e
Author: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
Date:   Tue Jun 23 23:27:31 2015 +0200

    Fix: get_cmdline_by_pid path length assumes a max pid of 65535

    PROC(5) mentions that "On 64-bit systems, pid_max can be set to any
    value up to 2^22 (PID_MAX_LIMIT, approximately 4 million)."

    We use 32 bits for simplicity's sake.

    Reported-by: Zhenyu Ren <zhenyu.ren@aliyun.com>
    Signed-off-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.=
com>


Thanks!
J=C3=A9r=C3=A9mie



>
> Thanks
> zhenyu.ren
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7b15fcb7743c870519368e09
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Jun 4, 2015 at 5:00 AM, zhenyu.ren <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:zhenyu.ren@aliyun.com" target=3D"_blank">zhenyu.ren@aliyun.com<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);=
border-left-style:solid;padding-left:1ex">Hi,dev-team<br>
<br>
=C2=A0 =C2=A0As the subject is my problem. It seems that the function get_c=
mdline_by_pid() will fail if kernel.pid_max &gt; 100000 (i.e. 131072)<br>
<br>
static char *get_cmdline_by_pid(pid_t pid)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *fp =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *cmdline =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char path[20];=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ca=
n&#39;t go bigger than /proc/65535/cmdline */<br>
<br>
<br>
=C2=A0I think path[20] is not big enough .Do you have any better idea?<br><=
/blockquote><div><br></div><div>Good catch! Sorry for the delay, traveling =
has caused me to fall behind on e-mails... Catching up!</div><div><br></div=
><div>Based on PROC(5):</div><div><br></div><div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0/proc/sys/kernel/pid_max (since Linux 2.5.34)</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This =C2=A0file =C2=A0specifies the val=
ue at which PIDs wrap around</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (i.e., the value in this file is =C2=A0one =C2=A0greater =C2=
=A0than =C2=A0the</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 maximum PID).=C2=A0 PIDs greater than this value are not allo=E2=80=90<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cated; thus, the=
 value in this file also acts as =C2=A0a =C2=A0sys=E2=80=90</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tem-wide =C2=A0limit =C2=A0on=
 =C2=A0the =C2=A0total =C2=A0number =C2=A0of processes and</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 threads.=C2=A0 The default value=
 for this file, 32768, results</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 in =C2=A0the =C2=A0same =C2=A0range =C2=A0of =C2=A0PIDs as o=
n earlier kernels.=C2=A0 On</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 32-bit platforms, 32768 is the maximum value for pid_max.</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On =C2=A064-bit sys=
tems, pid_max can be set to any value up to</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 2^22 (PID_MAX_LIMIT, approximately 4 million).<=
/div></div><div><br></div><div>I have introduced a fix in master, stable-2.=
6 and stable-2.5.</div><div><br></div><div><div>commit fae9a062a468c47fc71e=
f7aa96374bf9d87d137e</div><div>Author: J=C3=A9r=C3=A9mie Galarneau &lt;<a h=
ref=3D"mailto:jeremie.galarneau@efficios.com">jeremie.galarneau@efficios.co=
m</a>&gt;</div><div>Date: =C2=A0 Tue Jun 23 23:27:31 2015 +0200</div><div><=
br></div><div>=C2=A0 =C2=A0 Fix: get_cmdline_by_pid path length assumes a m=
ax pid of 65535</div><div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 PROC(=
5) mentions that &quot;On 64-bit systems, pid_max can be set to any</div><d=
iv>=C2=A0 =C2=A0 value up to 2^22 (PID_MAX_LIMIT, approximately 4 million).=
&quot;</div><div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 We use 32 bits=
 for simplicity&#39;s sake.</div><div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =
=C2=A0 Reported-by: Zhenyu Ren &lt;<a href=3D"mailto:zhenyu.ren@aliyun.com"=
>zhenyu.ren@aliyun.com</a>&gt;</div><div>=C2=A0 =C2=A0 Signed-off-by: J=C3=
=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.co=
m">jeremie.galarneau@efficios.com</a>&gt;</div></div><div><br></div><div><b=
r></div><div>Thanks!<br></div><div>J=C3=A9r=C3=A9mie</div><div><br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex">
<br>
Thanks<br>
zhenyu.ren<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>J=C3=A9=
r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com=
" target=3D"_blank">http://www.efficios.com</a></div>
</div></div>

--047d7b15fcb7743c870519368e09--


--===============0829362644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0829362644==--
