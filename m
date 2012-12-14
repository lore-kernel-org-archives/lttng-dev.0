From: Radhika Chowdary <radhika.putty@gmail.com>
Subject: Re: Unable to import big LTTng traces
Date: Fri, 14 Dec 2012 09:02:20 +0530
Message-ID: <CAMSKo86n_0Rpgz6KGZTgHpLtuHM8t2UYpvDF5CeFD5Oi+_TqWQ__30293.1048944176$1355455993$gmane$org@mail.gmail.com>
References: <CAMSKo873P7Tm_xGoYfSx1aQMSO7AnQrpUSUCpS-r_mP5EpTOcw@mail.gmail.com>
	<50CA1992.9020706@voxpopuli.im>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1610215528=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <radhika.putty@gmail.com>) id 1TjM0g-0002bY-09
	for lttng-dev@lists.lttng.org; Thu, 13 Dec 2012 22:32:26 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so2908064obb.35
	for <lttng-dev@lists.lttng.org>; Thu, 13 Dec 2012 19:32:20 -0800 (PST)
In-Reply-To: <50CA1992.9020706@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1610215528==
Content-Type: multipart/alternative; boundary=f46d043be10ed717c304d0c7ada5

--f46d043be10ed717c304d0c7ada5
Content-Type: text/plain; charset=ISO-8859-1

Thanks for the replies. I think I should be patient while the trace file
imports

/Radhika

On Thu, Dec 13, 2012 at 11:38 PM, Alexandre Montplaisir <
alexmonthy@voxpopuli.im> wrote:

> On 12-12-12 12:59 AM, Radhika Chowdary wrote:
> > Hi
> >
> > I am using linuxtools plugins for importing LTTng traces. I have a trace
> > folder of size 400MB and when I try to import it in the Traces folder it
> > takes for ever to import it. At the bottom left corner I see Indexing...
> > Events view gets populated soon but not others.
>
> Hi,
>
> It is expected that the indexing phase takes a while for very large
> trace. It could probably be optimized a bit too, since we haven't spent
> much time on performance improvements. Good news is that once indexed,
> it will be faster to reopen the same trace later on.
>
> We have not yet implemented a percentage progression monitor for the
> indexing job. This is not trivial since it has to be implemented
> differently depending on the trace type, but would definitely be nice to
> have.
>
> If you use the latest master branch, the timestamps for the start and
> end of the histogram are now correctly formatted, so it is possible to
> know roughly where the indexing is at, provided you know the end time of
> your trace. I'd suggest trying that out to make sure it's not stopping
> at some point, which would be a bug.
>
> > Is there a limit on the size of traces that it can import?
>
> There is no theoretical limit on the trace size that can be imported. It
> is capped only by your patience ;)  and the amount of available disk
> space, since the index files can be quite big too.
>
>
> Cheers,
> Alex
>
>

--f46d043be10ed717c304d0c7ada5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the replies. I think I should be patient while the trace file im=
ports<div><br></div><div>/Radhika<br><br><div class=3D"gmail_quote">On Thu,=
 Dec 13, 2012 at 11:38 PM, Alexandre Montplaisir <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:alexmonthy@voxpopuli.im" target=3D"_blank">alexmonthy@voxpopu=
li.im</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 12-12-12 12:59 AM, Radh=
ika Chowdary wrote:<br>
&gt; Hi<br>
&gt;<br>
&gt; I am using linuxtools plugins for importing LTTng traces. I have a tra=
ce<br>
&gt; folder of size 400MB and when I try to import it in the Traces folder =
it<br>
&gt; takes for ever to import it. At the bottom left corner I see Indexing.=
..<br>
&gt; Events view gets populated soon but not others.<br>
<br>
</div>Hi,<br>
<br>
It is expected that the indexing phase takes a while for very large<br>
trace. It could probably be optimized a bit too, since we haven&#39;t spent=
<br>
much time on performance improvements. Good news is that once indexed,<br>
it will be faster to reopen the same trace later on.<br>
<br>
We have not yet implemented a percentage progression monitor for the<br>
indexing job. This is not trivial since it has to be implemented<br>
differently depending on the trace type, but would definitely be nice to<br=
>
have.<br>
<br>
If you use the latest master branch, the timestamps for the start and<br>
end of the histogram are now correctly formatted, so it is possible to<br>
know roughly where the indexing is at, provided you know the end time of<br=
>
your trace. I&#39;d suggest trying that out to make sure it&#39;s not stopp=
ing<br>
at some point, which would be a bug.<br>
<div class=3D"im"><br>
&gt; Is there a limit on the size of traces that it can import?<br>
<br>
</div>There is no theoretical limit on the trace size that can be imported.=
 It<br>
is capped only by your patience ;) =A0and the amount of available disk<br>
space, since the index files can be quite big too.<br>
<br>
<br>
Cheers,<br>
Alex<br>
<br>
</blockquote></div><br></div>

--f46d043be10ed717c304d0c7ada5--


--===============1610215528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1610215528==--
