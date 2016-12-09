From: Anders Wallin <wallinux@gmail.com>
Subject: Re: Snapshot gives no events after calling it more then
 the number sub-buffers in the channel
Date: Fri, 9 Dec 2016 10:24:14 +0100
Message-ID: <CAF2baFd-L3Lo9jzAa9gPT=grKDereGD_K-upjygtaTpWbE_Jaw__47078.8718703718$1481275472$gmane$org@mail.gmail.com>
References: <CAF2baFcNqGtivF-GnVMKegWBtx65E_UZR86PGD0dQWdMXVx18g@mail.gmail.com>
 <1208499797.31516.1481218522033.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8440349876124643762=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3tZn0k5Kcczsy4
 for <lttng-dev@lists.lttng.org>; Fri,  9 Dec 2016 09:26:14 +0000 (UTC)
Received: by mail-wm0-x242.google.com with SMTP id a20so2713227wme.2
 for <lttng-dev@lists.lttng.org>; Fri, 09 Dec 2016 01:24:16 -0800 (PST)
In-Reply-To: <1208499797.31516.1481218522033.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8440349876124643762==
Content-Type: multipart/alternative; boundary=f403045ebea2526d2a05433651fe

--f403045ebea2526d2a05433651fe
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 8, 2016 at 6:35 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Dec 7, 2016, at 9:27 AM, Anders Wallin <wallinux@gmail.com>
> wrote:
>
> Hi,
> Taking a number of snapshots always showed the events in the buffer,
> before the
> commit de3fb857f034c208c135a10a3cdec2dfe43fbda6
>
>     Fix: ust-consumer: flush empty packets on snapshot channel
>     Snapshot operation on a non-stopped stream should use a "final" flush
> to
>     ensure empty packets are flushed, so we gather timestamps at the moment
>     where the snapshot is taken. This is important for streams that have a
>     low amount of activity, which might be on an empty packet when the
>     snapshot is triggered.
>
> After this the number of snapshots that can be taken and getting events is
> equal to number of sub-buffers!?
> I think this i BUG!
>
>
> Hi,
>
> This has been done on purpose. By moving one packet forward even if there
> is no data
> in the current packet, we are able to save the end timestamp corresponding
> to the moment the
> snapshot is taken, which gives us information about the proper time-range
> to consider for each
> stream.
>
> This is needed for the babeltrace stream intersection feature to work
> properly on
> snapshots in cases where some streams have low even throughput.
>
> Can you describe your use-cases that rely on the prior behavior ?
>
> Thanks,
>
> Mathieu
>

The use-case is that we rely on that all events are still in the buffer.
Taken the snapshot is done by different applications/people.
We know the the snapshots will be overwritten when the buffer is full.
This patch introduced a new behavior in a stable release serie which is
strange.  For me this would be something that could change if you make a
new feature
release, even if it should break use and test cases when we moved to this
version.
I understand that the patch fixes another issue, but is there any other way
to solve this issue and keep the existing behavior?

Anders Wallin

--f403045ebea2526d2a05433651fe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 8, 2016 at 6:35 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.de=
snoyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><span class=3D"gmail-"><span id=3D"gmail-m_68176117166=
25125080zwchr">----- On Dec 7, 2016, at 9:27 AM, Anders Wallin &lt;<a href=
=3D"mailto:wallinux@gmail.com" target=3D"_blank">wallinux@gmail.com</a>&gt;=
 wrote:<br></span></span><div><span class=3D"gmail-"><blockquote style=3D"b=
order-left:2px solid rgb(16,16,255);margin-left:5px;padding-left:5px;color:=
rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:none;font-f=
amily:helvetica,arial,sans-serif;font-size:12pt"><div dir=3D"ltr">Hi,<br><d=
iv>Taking a number of snapshots always showed the events in the buffer, bef=
ore the</div><div>commit de3fb857f034c208c135a10a3cdec2<wbr>dfe43fbda6=C2=
=A0</div><div><br><div><div>=C2=A0 =C2=A0 Fix: ust-consumer: flush empty pa=
ckets on snapshot channel</div><div>=C2=A0 =C2=A0 Snapshot operation on a n=
on-stopped stream should use a &quot;final&quot; flush to</div><div>=C2=A0 =
=C2=A0 ensure empty packets are flushed, so we gather timestamps at the mom=
ent</div><div>=C2=A0 =C2=A0 where the snapshot is taken. This is important =
for streams that have a</div><div>=C2=A0 =C2=A0 low amount of activity, whi=
ch might be on an empty packet when the</div><div>=C2=A0 =C2=A0 snapshot is=
 triggered.</div><br><div>After this the number of snapshots that can be ta=
ken and getting events is equal to number of sub-buffers!?</div><div>I thin=
k this i BUG!</div></div></div></div></blockquote><div><br></div></span><di=
v>Hi,<br></div><div><br></div><div>This has been done on purpose. By moving=
 one packet forward even if there is no data</div><div>in the current packe=
t, we are able to save the end timestamp corresponding to the moment the</d=
iv><div>snapshot is taken, which gives us information about the proper time=
-range to consider for each<br></div><div>stream.<br></div><div><br></div><=
div>This is needed for the babeltrace stream intersection feature to work p=
roperly on<br></div><div>snapshots in cases where some streams have low eve=
n throughput.<br></div><div><br></div><div>Can you describe your use-cases =
that rely on the prior behavior ?<br></div><div><br></div><div>Thanks,<br><=
/div><div><br></div><div>Mathieu</div><div></div></div></blockquote></div><=
br>The use-case is that we rely on that all events are still in the buffer.=
 Taken the snapshot is done by different applications/people.</div><div cla=
ss=3D"gmail_extra">We know the the snapshots will be overwritten when the b=
uffer is full.=C2=A0</div><div class=3D"gmail_extra">This patch introduced =
a new behavior in a stable release serie which is strange.=C2=A0 For me thi=
s would be something that could change if you make a new feature</div><div =
class=3D"gmail_extra">release, even if it should break use and test cases w=
hen we moved to this version.</div><div class=3D"gmail_extra">I understand =
that the patch fixes another issue, but is there any other way to solve thi=
s issue and keep the existing behavior?<br><br clear=3D"all"><div><div clas=
s=3D"gmail_signature">Anders Wallin</div></div>
</div></div>

--f403045ebea2526d2a05433651fe--

--===============8440349876124643762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8440349876124643762==--
