From: syed zaidi <zaidi1039@gmail.com>
Subject: Re: LTTng buffer mode
Date: Fri, 26 Feb 2016 01:12:54 -0800
Message-ID: <CAD6O9aryfG_Wh39620c2K_CVB8Oi0ZaVnQbYzGdRq1b1WMEDbQ__1133.18745648048$1456478033$gmane$org@mail.gmail.com>
References: <BY2PR15MB0759C952513EFB6E18812650ABAE0@BY2PR15MB0759.namprd15.prod.outlook.com>
 <CAB4xu_1qu7ezjfafSHc_CmM=YzcNhu9Oxyim=kd7N2U-OTJwZw@mail.gmail.com>
 <BY2PR15MB07598F61A09D22D0CBF9B785ABA00@BY2PR15MB0759.namprd15.prod.outlook.com>
 <829984174.3472.1455992223842.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2050938611=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zaidi1039@gmail.com>) id 1aZESK-0003gk-7h
 for lttng-dev@lists.lttng.org; Fri, 26 Feb 2016 04:13:01 -0500
Received: by mail-ig0-f173.google.com with SMTP id y8so31864681igp.1
 for <lttng-dev@lists.lttng.org>; Fri, 26 Feb 2016 01:13:00 -0800 (PST)
In-Reply-To: <829984174.3472.1455992223842.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2050938611==
Content-Type: multipart/alternative; boundary=001a113319da4f20cc052ca8b429

--001a113319da4f20cc052ca8b429
Content-Type: text/plain; charset=UTF-8

Hi Mathieu,

I have few questions related to the questions above and please forgive me
for my ignorance in advance.
1. When LTTng creates the buffers lets say per uid, the files that show up
in LTTng folder, are those files that LTTng has stopped writing in? What I
mean is, are those files still being written to or they are safe to be
moved.

2. If I want to collect traces lets say every 5 mins for the last 5 mins
while LTTng keeps running. What is the best approach? Do I just run
BabelTrace on the folder and remove all files from the folder to create
space for next files and keep repeating?

3. I understand that I should delete the corresponding .idx file for each
log file that I remove, what about metadata file? Do I remove it or leave
it as is?

4. The trace file produced by Babeltrace, does it guarantee that the file
has traces from all the users and the core till the time stamp of the last
line?'
For example if the last line of the trace file looks like this
23:00:00.912089772,...,...
Does that mean that the trace file has all the traces until that time?

Thanks
Ammar

On Sat, Feb 20, 2016 at 10:17 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi,
>
> LTTng implements per-cpu buffers to eliminate false-sharing between
> CPUs. Babeltrace and Trace Compass implement iterators that allow
> doing the merge of those per-cpu buffers into a single stream on
> the fly. Users of Babeltrace and Trace Compass should not have to
> worry about doing this merge.
>
> Since LTTng is inherently multi-buffers, we also use this buffer
> merging scheme to deal with tracefile rotation, multi-channel, and
> combining traces gathered from various processes/user IDs/kernel vs
> userspace.
>
> So my question here is: why you say it is much more difficult for
> you to deal with those multiple buffers ? Since there are already
> libraries in Babeltrace that do that for you, I would expect this
> to be a non-issue.
>
> Although it would be technically possible to implement a ring
> buffer shared across CPUs, it would be inefficient, and we would
> need a good justification for adding this complexity to the
> tracers.
>
> Thanks,
>
> Mathieu
>
>
> ----- On Feb 19, 2016, at 4:00 AM, Jeffrey Chen cpthk@hotmail.com wrote:
>
> > Thanks.
> > If we make changes to LTTng to add this feature, would it violate the
> LTTng
> > design principle in any way? Thanks.
> >
> >
> > ________________________________________
> > From: Philippe Proulx <eeppeliteloop@gmail.com>
> > Sent: Tuesday, February 16, 2016 5:02 PM
> > To: Jeffrey Chen
> > Cc: lttng-dev@lists.lttng.org
> > Subject: Re: [lttng-dev] LTTng buffer mode
> >
> > No you cannot.
> >
> > There's no hidden global buffering scheme option for user space tracing.
> >
> > From the LTTng documentation:
> >
> >> In the user space tracing domain, two buffering schemes are available
> >> when creating a channel:
> >>
> >> Per-PID buffering: keep one ring buffer per process.
> >> Per-UID buffering: keep one ring buffer for all processes of a single
> user.
> >
> > and:
> >
> >> The Linux kernel tracing domain only has one available buffering scheme
> >> which is to use a single ring buffer for the whole system.
> >
> > Phil
> >
> > On Tue, Feb 16, 2016 at 7:55 PM, Jeffrey Chen <cpthk@hotmail.com> wrote:
> >> Hi LTTng community:
> >>
> >>
> >> I have a question about LTTng buffer mode. According to documentation,
> LTTng
> >> supports 2 buffer modes, per-pid, and per-uid. Is there any mode to
> have a
> >> global buffer that does not have separate buffers? The reason I asked is
> >> because, LTTng writes different buffer traces to different
> directory/file.
> >> It is much more difficult for us to post-process separate directories.
> We
> >> would like to have all traces write into one single buffer and
> >> directory/file, so it is easier to do post-processing. Thanks.
> >>
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--001a113319da4f20cc052ca8b429
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mathieu,<div><br></div><div>I have few questions relate=
d to the questions above and please forgive me for my ignorance in advance.=
</div><div>1. When LTTng creates the buffers lets say per uid, the files th=
at show up in LTTng folder, are those files that LTTng has stopped writing =
in? What I mean is, are those files still being written to or they are safe=
 to be moved.</div><div><br></div><div>2. If I want to collect traces lets =
say every 5 mins for the last 5 mins while LTTng keeps running. What is the=
 best approach? Do I just run BabelTrace on the folder and remove all files=
 from the folder to create space for next files and keep repeating? =C2=A0<=
/div><div><br></div><div>3. I understand that I should delete the correspon=
ding .idx file for each log file that I remove, what about metadata file? D=
o I remove it or leave it as is?</div><div><br></div><div>4. The trace file=
 produced by Babeltrace, does it guarantee that the file has traces from al=
l the users and the core till the time stamp of the last line?&#39;</div><d=
iv>For example if the last line of the trace file looks like this</div><div=
>23:00:00.912089772,...,...</div><div>Does that mean that the trace file ha=
s all the traces until that time?</div><div><br></div><div>Thanks</div><div=
>Ammar</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Sat, Feb 20, 2016 at 10:17 AM, Mathieu Desnoyers <span dir=3D"ltr">&lt;=
<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu=
.desnoyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">Hi,<br>
<br>
LTTng implements per-cpu buffers to eliminate false-sharing between<br>
CPUs. Babeltrace and Trace Compass implement iterators that allow<br>
doing the merge of those per-cpu buffers into a single stream on<br>
the fly. Users of Babeltrace and Trace Compass should not have to<br>
worry about doing this merge.<br>
<br>
Since LTTng is inherently multi-buffers, we also use this buffer<br>
merging scheme to deal with tracefile rotation, multi-channel, and<br>
combining traces gathered from various processes/user IDs/kernel vs<br>
userspace.<br>
<br>
So my question here is: why you say it is much more difficult for<br>
you to deal with those multiple buffers ? Since there are already<br>
libraries in Babeltrace that do that for you, I would expect this<br>
to be a non-issue.<br>
<br>
Although it would be technically possible to implement a ring<br>
buffer shared across CPUs, it would be inefficient, and we would<br>
need a good justification for adding this complexity to the<br>
tracers.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
----- On Feb 19, 2016, at 4:00 AM, Jeffrey Chen <a href=3D"mailto:cpthk@hot=
mail.com">cpthk@hotmail.com</a> wrote:<br>
<br>
&gt; Thanks.<br>
&gt; If we make changes to LTTng to add this feature, would it violate the =
LTTng<br>
&gt; design principle in any way? Thanks.<br>
&gt;<br>
&gt;<br>
&gt; ________________________________________<br>
&gt; From: Philippe Proulx &lt;<a href=3D"mailto:eeppeliteloop@gmail.com">e=
eppeliteloop@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, February 16, 2016 5:02 PM<br>
&gt; To: Jeffrey Chen<br>
&gt; Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng=
.org</a><br>
&gt; Subject: Re: [lttng-dev] LTTng buffer mode<br>
&gt;<br>
&gt; No you cannot.<br>
&gt;<br>
&gt; There&#39;s no hidden global buffering scheme option for user space tr=
acing.<br>
&gt;<br>
&gt; From the LTTng documentation:<br>
&gt;<br>
&gt;&gt; In the user space tracing domain, two buffering schemes are availa=
ble<br>
&gt;&gt; when creating a channel:<br>
&gt;&gt;<br>
&gt;&gt; Per-PID buffering: keep one ring buffer per process.<br>
&gt;&gt; Per-UID buffering: keep one ring buffer for all processes of a sin=
gle user.<br>
&gt;<br>
&gt; and:<br>
&gt;<br>
&gt;&gt; The Linux kernel tracing domain only has one available buffering s=
cheme<br>
&gt;&gt; which is to use a single ring buffer for the whole system.<br>
&gt;<br>
&gt; Phil<br>
&gt;<br>
&gt; On Tue, Feb 16, 2016 at 7:55 PM, Jeffrey Chen &lt;<a href=3D"mailto:cp=
thk@hotmail.com">cpthk@hotmail.com</a>&gt; wrote:<br>
&gt;&gt; Hi LTTng community:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I have a question about LTTng buffer mode. According to documentat=
ion, LTTng<br>
&gt;&gt; supports 2 buffer modes, per-pid, and per-uid. Is there any mode t=
o have a<br>
&gt;&gt; global buffer that does not have separate buffers? The reason I as=
ked is<br>
&gt;&gt; because, LTTng writes different buffer traces to different directo=
ry/file.<br>
&gt;&gt; It is much more difficult for us to post-process separate director=
ies. We<br>
&gt;&gt; would like to have all traces write into one single buffer and<br>
&gt;&gt; directory/file, so it is easier to do post-processing. Thanks.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng=
.org</a><br>
&gt;&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-d=
ev" rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mai=
lman/listinfo/lttng-dev</a><br>
&gt;&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</a><br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
</div></div></blockquote></div><br></div>

--001a113319da4f20cc052ca8b429--


--===============2050938611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2050938611==--
