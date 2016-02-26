From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng buffer mode
Date: Fri, 26 Feb 2016 18:07:05 +0000 (UTC)
Message-ID: <1263166217.9071.1456510025603.JavaMail.zimbra__37301.7413694926$1456510096$gmane$org@efficios.com>
References: <BY2PR15MB0759C952513EFB6E18812650ABAE0@BY2PR15MB0759.namprd15.prod.outlook.com>
 <CAB4xu_1qu7ezjfafSHc_CmM=YzcNhu9Oxyim=kd7N2U-OTJwZw@mail.gmail.com>
 <BY2PR15MB07598F61A09D22D0CBF9B785ABA00@BY2PR15MB0759.namprd15.prod.outlook.com>
 <829984174.3472.1455992223842.JavaMail.zimbra@efficios.com>
 <CAD6O9aryfG_Wh39620c2K_CVB8Oi0ZaVnQbYzGdRq1b1WMEDbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1195619572=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aZMnL-0006j8-Kp
 for lttng-dev@lists.lttng.org; Fri, 26 Feb 2016 13:07:18 -0500
In-Reply-To: <CAD6O9aryfG_Wh39620c2K_CVB8Oi0ZaVnQbYzGdRq1b1WMEDbQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: syed zaidi <zaidi1039@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1195619572==
Content-Type: multipart/alternative;
	boundary="----=_Part_9070_1269716780.1456510025602"

------=_Part_9070_1269716780.1456510025602
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Feb 26, 2016, at 4:12 AM, syed zaidi <zaidi1039@gmail.com> wrote: 

> Hi Mathieu,
> I have few questions related to the questions above and please forgive me for my
> ignorance in advance.
> 1. When LTTng creates the buffers lets say per uid, the files that show up in
> LTTng folder, are those files that LTTng has stopped writing in? What I mean
> is, are those files still being written to or they are safe to be moved.

They are still being written to. 

> 2. If I want to collect traces lets say every 5 mins for the last 5 mins while
> LTTng keeps running. What is the best approach? Do I just run BabelTrace on the
> folder and remove all files from the folder to create space for next files and
> keep repeating?

I would not use Babeltrace on the target, but rather just move the CTF files. 

You could swap between two sessions to do that: lttng supports multiple 
concurrent sessions. Create and start a new session before you stop, 
destroy, and move away the old session, every 5 minutes... 

> 3. I understand that I should delete the corresponding .idx file for each log
> file that I remove, what about metadata file? Do I remove it or leave it as is?

You need to leave it as is. 

> 4. The trace file produced by Babeltrace, does it guarantee that the file has
> traces from all the users and the core till the time stamp of the last line?'
> For example if the last line of the trace file looks like this
> 23:00:00.912089772,...,...
> Does that mean that the trace file has all the traces until that time?

It depends on your tracing mode (discard vs snapshot buffers). In discard 
mode (default if you don't use the --snapshot option on lttng create), 
Babeltrace will print on stderr whenever it encounters discarded events. 

Best regards, 

Mathieu 

> Thanks
> Ammar

> On Sat, Feb 20, 2016 at 10:17 AM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

>> Hi,

>> LTTng implements per-cpu buffers to eliminate false-sharing between
>> CPUs. Babeltrace and Trace Compass implement iterators that allow
>> doing the merge of those per-cpu buffers into a single stream on
>> the fly. Users of Babeltrace and Trace Compass should not have to
>> worry about doing this merge.

>> Since LTTng is inherently multi-buffers, we also use this buffer
>> merging scheme to deal with tracefile rotation, multi-channel, and
>> combining traces gathered from various processes/user IDs/kernel vs
>> userspace.

>> So my question here is: why you say it is much more difficult for
>> you to deal with those multiple buffers ? Since there are already
>> libraries in Babeltrace that do that for you, I would expect this
>> to be a non-issue.

>> Although it would be technically possible to implement a ring
>> buffer shared across CPUs, it would be inefficient, and we would
>> need a good justification for adding this complexity to the
>> tracers.

>> Thanks,

>> Mathieu

>> ----- On Feb 19, 2016, at 4:00 AM, Jeffrey Chen cpthk@hotmail.com wrote:

>> > Thanks.
>> > If we make changes to LTTng to add this feature, would it violate the LTTng
>> > design principle in any way? Thanks.


>> > ________________________________________
>> > From: Philippe Proulx < eeppeliteloop@gmail.com >
>> > Sent: Tuesday, February 16, 2016 5:02 PM
>> > To: Jeffrey Chen
>> > Cc: lttng-dev@lists.lttng.org
>> > Subject: Re: [lttng-dev] LTTng buffer mode

>> > No you cannot.

>> > There's no hidden global buffering scheme option for user space tracing.

>> > From the LTTng documentation:

>> >> In the user space tracing domain, two buffering schemes are available
>> >> when creating a channel:

>> >> Per-PID buffering: keep one ring buffer per process.
>> >> Per-UID buffering: keep one ring buffer for all processes of a single user.

>> > and:

>> >> The Linux kernel tracing domain only has one available buffering scheme
>> >> which is to use a single ring buffer for the whole system.

>> > Phil

>> > On Tue, Feb 16, 2016 at 7:55 PM, Jeffrey Chen < cpthk@hotmail.com > wrote:
>> >> Hi LTTng community:


>> >> I have a question about LTTng buffer mode. According to documentation, LTTng
>> >> supports 2 buffer modes, per-pid, and per-uid. Is there any mode to have a
>> >> global buffer that does not have separate buffers? The reason I asked is
>> >> because, LTTng writes different buffer traces to different directory/file.
>> >> It is much more difficult for us to post-process separate directories. We
>> >> would like to have all traces write into one single buffer and
>> >> directory/file, so it is easier to do post-processing. Thanks.



>> >> _______________________________________________
>> >> lttng-dev mailing list
>> >> lttng-dev@lists.lttng.org
>> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_9070_1269716780.1456510025602
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Feb 26, 2016, at 4:12 AM, syed zaidi &lt;zaidi1039@gmail.com&g=
t; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote =
style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;col=
or:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fami=
ly:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi Mathieu,=
<br><div>I have few questions related to the questions above and please for=
give me for my ignorance in advance.</div><div>1. When LTTng creates the bu=
ffers lets say per uid, the files that show up in LTTng folder, are those f=
iles that LTTng has stopped writing in? What I mean is, are those files sti=
ll being written to or they are safe to be moved.</div></div></blockquote><=
div><br></div><div>They are still being written to.<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left=
:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt;"><div dir=3D"ltr"><br><div>2. If I want to collec=
t traces lets say every 5 mins for the last 5 mins while LTTng keeps runnin=
g. What is the best approach? Do I just run BabelTrace on the folder and re=
move all files from the folder to create space for next files and keep repe=
ating? &nbsp;</div></div></blockquote><div><br></div><div>I would not use B=
abeltrace on the target, but rather just move the CTF files.<br data-mce-bo=
gus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>You could swap bet=
ween two sessions to do that: lttng supports multiple<br data-mce-bogus=3D"=
1"></div><div>concurrent sessions. Create and start a new session before yo=
u stop,<br data-mce-bogus=3D"1"></div><div>destroy, and move away the old s=
ession, every 5 minutes...<br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><div dir=3D"ltr"><br><div>3. I understand that I should delete the corres=
ponding .idx file for each log file that I remove, what about metadata file=
? Do I remove it or leave it as is?</div></div></blockquote><div><br></div>=
<div>You need to leave it as is.<br data-mce-bogus=3D"1"></div><div><br dat=
a-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;=
margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:n=
ormal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size=
:12pt;"><div dir=3D"ltr"><br><div>4. The trace file produced by Babeltrace,=
 does it guarantee that the file has traces from all the users and the core=
 till the time stamp of the last line?'</div><div>For example if the last l=
ine of the trace file looks like this</div><div>23:00:00.912089772,...,...<=
/div><div>Does that mean that the trace file has all the traces until that =
time?</div></div></blockquote><div>It depends on your tracing mode (discard=
 vs snapshot buffers). In discard<br></div><div>mode (default if you don't =
use the --snapshot option on lttng create),<br data-mce-bogus=3D"1"></div><=
div>Babeltrace will print on stderr whenever it encounters discarded events=
.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Be=
st regards,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></d=
iv><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"=
></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=
=3D"ltr"><br><div>Thanks</div><div>Ammar</div></div><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote">On Sat, Feb 20, 2016 at 10:17 AM, Mathie=
u Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@effic=
ios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Hi,<br><br>
LTTng implements per-cpu buffers to eliminate false-sharing between<br>
CPUs. Babeltrace and Trace Compass implement iterators that allow<br>
doing the merge of those per-cpu buffers into a single stream on<br>
the fly. Users of Babeltrace and Trace Compass should not have to<br>
worry about doing this merge.<br><br>
Since LTTng is inherently multi-buffers, we also use this buffer<br>
merging scheme to deal with tracefile rotation, multi-channel, and<br>
combining traces gathered from various processes/user IDs/kernel vs<br>
userspace.<br><br>
So my question here is: why you say it is much more difficult for<br>
you to deal with those multiple buffers ? Since there are already<br>
libraries in Babeltrace that do that for you, I would expect this<br>
to be a non-issue.<br><br>
Although it would be technically possible to implement a ring<br>
buffer shared across CPUs, it would be inefficient, and we would<br>
need a good justification for adding this complexity to the<br>
tracers.<br><br>
Thanks,<br><br>
Mathieu<br><div class=3D"HOEnZb"><div class=3D"h5"><br><br>
----- On Feb 19, 2016, at 4:00 AM, Jeffrey Chen <a href=3D"mailto:cpthk@hot=
mail.com" target=3D"_blank">cpthk@hotmail.com</a> wrote:<br><br>
&gt; Thanks.<br>
&gt; If we make changes to LTTng to add this feature, would it violate the =
LTTng<br>
&gt; design principle in any way? Thanks.<br>
&gt;<br>
&gt;<br>
&gt; ________________________________________<br>
&gt; From: Philippe Proulx &lt;<a href=3D"mailto:eeppeliteloop@gmail.com" t=
arget=3D"_blank">eeppeliteloop@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, February 16, 2016 5:02 PM<br>
&gt; To: Jeffrey Chen<br>
&gt; Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a><br>
&gt; Subject: Re: [lttng-dev] LTTng buffer mode<br>
&gt;<br>
&gt; No you cannot.<br>
&gt;<br>
&gt; There's no hidden global buffering scheme option for user space tracin=
g.<br>
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
thk@hotmail.com" target=3D"_blank">cpthk@hotmail.com</a>&gt; wrote:<br>
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
&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a><br>
&gt;&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-d=
ev" rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mai=
lman/listinfo/lttng-dev</a><br>
&gt;&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</a><br><br></div></div><span class=3D"HOEnZb"><span sty=
le=3D"color: #888888;" data-mce-style=3D"color: #888888;" color=3D"#888888"=
>--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</span></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
_______________________________________________<br>
lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" targ=
et=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"http://lists.lttn=
g.org/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_bla=
nk">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br></div>=
</div></blockquote></div></div><br></blockquote></div><div><br></div><div d=
ata-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS=
 Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_9070_1269716780.1456510025602--


--===============1195619572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1195619572==--
