From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: Warning: HOME environment variable not set.
Date: Tue, 24 Mar 2015 01:31:48 +0530
Message-ID: <CAM5kDqz8A+c-+X7ak=RFD4e9eHop5UHavJPNO5w4txq-C4sKWw__35833.5841483951$1427140978$gmane$org@mail.gmail.com>
References: <CAM5kDqw2R5+xy9t+sjet_PWt2+2fPh5ijbkKB_15NUJQUoKU5Q@mail.gmail.com>
 <CAL1ZhOM+RTpz2iiqYEM2RHTCK+PxBAXk54q8ykmnsac0-w4WoA@mail.gmail.com>
 <CAM5kDqxMTOj0TqZQjT0i+0MHmPxfvPUocgV0_erw4_7+pBtSDA@mail.gmail.com>
 <218306271.74676.1427117803698.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1745284104=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1Ya8Xq-0001M4-ES
 for lttng-dev@lists.lttng.org; Mon, 23 Mar 2015 16:01:56 -0400
Received: by wgra20 with SMTP id a20so154807663wgr.3
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2015 13:01:48 -0700 (PDT)
In-Reply-To: <218306271.74676.1427117803698.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1745284104==
Content-Type: multipart/alternative; boundary=089e013d195aeab6d60511fa22d2

--089e013d195aeab6d60511fa22d2
Content-Type: text/plain; charset=UTF-8

Thanks a lot, that helped.
Yes my process was resetting env variables.

-Anand Neeli

On Mon, Mar 23, 2015 at 7:06 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Perhaps your program is clearing its environment
> variables ? Or launched by a wrapper that clears
> the env. var. ?
>
> Can you try with a simple demo program to find our
> what is clearing those ?
>
> Thanks,
>
> Mathieu
>
>
> ------------------------------
>
> Hi All,
> I'm sorry to bump on this thread again.
>
> Is there any way to overcome this issue?
>
> Thanks,
> Anand Neeli
>
> On Wed, Mar 18, 2015 at 10:01 PM, Chidhu R <chid1989@gmail.com> wrote:
>
>> I too am getting the same errors. Inspite of setting LTTNG_HOME in my
>> program.
>>
>> On Tue, Mar 17, 2015 at 2:18 PM, Anand Neeli <anand.neeli@gmail.com>
>> wrote:
>>
>>> Hi All,
>>>
>>> any idea when do we get this error?
>>>
>>> app: libust[4745/4745]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>> app: libust[4751/4751]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>> app: libust[4760/4760]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>> app: libust[4780/4780]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>>
>>> i have set LTTNG_HOME=HOME=/home/root
>>> using 2.6
>>>
>>> Thanks,
>>> Anand Neeli
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--089e013d195aeab6d60511fa22d2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks a lot, that helped.<div>Yes my process was resettin=
g env variables.</div><div><br></div><div>-Anand Neeli</div></div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Mar 23, 2015 at 7:=
06 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.de=
snoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font=
-family:times new roman,new york,times,serif;font-size:12pt;color:#000000">=
<div>Perhaps your program is clearing its environment<br></div><div>variabl=
es ? Or launched by a wrapper that clears<br></div><div>the env. var. ?<br>=
</div><div><br></div><div>Can you try with a simple demo program to find ou=
r<br></div><div>what is clearing those ?<br></div><div><br></div><div>Thank=
s,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br></=
div><hr><div><div class=3D"h5"><blockquote style=3D"border-left:2px solid #=
1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-=
style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fo=
nt-size:12pt"><div dir=3D"ltr">Hi All,<div>I&#39;m sorry to bump on this th=
read again.</div><div><br></div><div>Is there any way to overcome this issu=
e?</div><div><br></div><div>Thanks,</div><div>Anand Neeli</div></div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Mar 18, 2015 at=
 10:01 PM, Chidhu R <span dir=3D"ltr">&lt;<a href=3D"mailto:chid1989@gmail.=
com" target=3D"_blank">chid1989@gmail.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><div dir=3D"ltr">I too am getting the same errors. I=
nspite of setting LTTNG_HOME in my program.=C2=A0</div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote"><div><div>On Tue, Mar 17, 2015 at 2:1=
8 PM, Anand Neeli <span dir=3D"ltr">&lt;<a href=3D"mailto:anand.neeli@gmail=
.com" target=3D"_blank">anand.neeli@gmail.com</a>&gt;</span> wrote:<br></di=
v></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div><div><div dir=3D"ltr">Hi All,<d=
iv><br></div><div>any idea when do we get this error?</div><div><br></div><=
div><div>app: libust[4745/4745]: Warning: HOME environment variable not set=
. Disabling LTTng-UST per-user tracing. (in setup_local_apps() at lttng-ust=
-comm.c:385)</div><div>app: libust[4751/4751]: Warning: HOME environment va=
riable not set. Disabling LTTng-UST per-user tracing. (in setup_local_apps(=
) at lttng-ust-comm.c:385)</div><div>app: libust[4760/4760]: Warning: HOME =
environment variable not set. Disabling LTTng-UST per-user tracing. (in set=
up_local_apps() at lttng-ust-comm.c:385)</div><div>app: libust[4780/4780]: =
Warning: HOME environment variable not set. Disabling LTTng-UST per-user tr=
acing. (in setup_local_apps() at lttng-ust-comm.c:385)</div></div><div><br>=
</div><div>i have set LTTNG_HOME=3DHOME=3D/home/root</div><div>using 2.6</d=
iv><div><br></div><div>Thanks,</div><div>Anand Neeli</div><div><br></div></=
div>
<br></div></div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>
</blockquote></div><br></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev</a><br></blockquote><div><br><br></div><div><br></di=
v></div></div><span class=3D"HOEnZb"><font color=3D"#888888"><div>-- <br></=
div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a><span name=3D"x"></span><br></div></font></span></div></div></blockquote>=
</div><br></div>

--089e013d195aeab6d60511fa22d2--


--===============1745284104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1745284104==--
