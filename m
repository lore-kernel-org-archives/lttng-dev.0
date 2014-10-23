From: Anand Neeli <anand.neeli@gmail.com>
Subject: health check and relaunch of lttng daemons
Date: Thu, 23 Oct 2014 12:37:40 +0530
Message-ID: <CAM5kDqzEEKLhpyWuU3+41AJO4wPdKoCyR-YSVnLXtxD1HxfdUQ__29598.523656796$1414048111$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1863456800=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XhCUx-00082F-48
 for lttng-dev@lists.lttng.org; Thu, 23 Oct 2014 03:07:52 -0400
Received: by mail-wi0-f179.google.com with SMTP id d1so1082727wiv.12
 for <lttng-dev@lists.lttng.org>; Thu, 23 Oct 2014 00:07:40 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1863456800==
Content-Type: multipart/alternative; boundary=f46d0442878653c932050611b814

--f46d0442878653c932050611b814
Content-Type: text/plain; charset=UTF-8

Hi All,
I have few queries related to notifications when lttng daemons die and
their spawning and health-check

- When relayd dies then sessiond gets error of connection reset, but it
doesnt try to reconnect to relayd again. It just lies on system without
being functional.

- on a system with multiple nodes, relayd can be spawned on any node. Is
there a way for the sessiond to discover or get relayd IP-address. (Again
in case relayd dies and gets spawned on different node, then sessiond has
to discover and re-connect)

- How is the health_check used. Is it deprecated? coz in lttng.h i see
extern LTTNG_DEPRECATED("This call is now obsolete.")
int lttng_health_check(enum lttng_health_component c);

If health_check can be used for relayd and sessiond?
Can anyone provide more pointers or example code for health check?


- it becomes really important to get notification/signal from relayd, so
that software can be added to respawn sessiond.
please let me know if there is anyway of doing this.


Thanks,
Anand Neeli




On Tue, Oct 21, 2014 at 12:10 AM, Anand Neeli <anand.neeli@gmail.com> wrote:

> one more point:
> if there is a way to kill/exit sessiond on a connection reset then will be
> easier to re-launch it again
>
> wondering if anything of that sort can be done
>
> Thanks,
> Anand Neeli
>
> On Tue, Oct 21, 2014 at 12:02 AM, Anand Neeli <anand.neeli@gmail.com>
> wrote:
>
>> Hi All,
>> if relayd gets killed i see there is connection reset which happens at
>> client.
>> Is there a way to relaunch the sessiond/consumerd on a connection reset?
>>
>> can some hooks be added or helper application be written to relaunch
>> sessiond in case exit of relayd or any other connection reset?
>>
>> Thanks,
>> Anand Neeli
>>
>
>

--f46d0442878653c932050611b814
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I have few queries related to notifications wh=
en lttng daemons die and their spawning and health-check</div><div><br></di=
v><div>- When relayd dies then sessiond gets error of connection reset, but=
 it doesnt try to reconnect to relayd again. It just lies on system without=
 being functional.</div><div><br></div><div>- on a system with multiple nod=
es, relayd can be spawned on any node. Is there a way for the sessiond to d=
iscover or get relayd IP-address. (Again in case relayd dies and gets spawn=
ed on different node, then sessiond has to discover and re-connect)</div><d=
iv><br></div><div>- How is the health_check used. Is it deprecated? coz in =
lttng.h i see</div><div><div>extern LTTNG_DEPRECATED(&quot;This call is now=
 obsolete.&quot;)</div><div>int lttng_health_check(enum lttng_health_compon=
ent c);</div></div><div><br></div><div>If health_check can be used for rela=
yd and sessiond?</div><div>Can anyone provide more pointers or example code=
 for health check?</div><div><br></div><div><br></div><div>- it becomes rea=
lly important to get notification/signal from relayd, so that software can =
be added to respawn sessiond.=C2=A0</div><div>please let me know if there i=
s anyway of doing this.</div><div><br></div><div><br></div><div>Thanks,</di=
v><div>Anand Neeli</div><div><br></div><div><br></div><div><br><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Oct 21, 2014 at 12:=
10 AM, Anand Neeli <span dir=3D"ltr">&lt;<a href=3D"mailto:anand.neeli@gmai=
l.com" target=3D"_blank">anand.neeli@gmail.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padd=
ing-left:1ex"><div dir=3D"ltr">one more point:<div>if there is a way to kil=
l/exit sessiond on a connection reset then will be easier to re-launch it a=
gain</div><div><br></div><div>wondering if anything of that sort can be don=
e</div><div><br></div><div>Thanks,</div><div>Anand Neeli</div></div><div cl=
ass=3D""><div class=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Tue, Oct 21, 2014 at 12:02 AM, Anand Neeli <span dir=3D"ltr">&=
lt;<a href=3D"mailto:anand.neeli@gmail.com" target=3D"_blank">anand.neeli@g=
mail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex"><div dir=3D"ltr">Hi Al=
l,<div>if relayd gets killed i see there is connection reset which happens =
at client.</div><div>Is there a way to relaunch the sessiond/consumerd on a=
 connection reset?</div><div><br></div><div>can some hooks be added or help=
er application be written to relaunch sessiond in case exit of relayd or an=
y other connection reset?</div><div><br></div><div>Thanks,</div><div>Anand =
Neeli</div></div>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div></div></div>

--f46d0442878653c932050611b814--


--===============1863456800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1863456800==--
