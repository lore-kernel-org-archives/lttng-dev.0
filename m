From: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building patches.
Date: Tue, 27 Aug 2013 17:02:19 +0200
Message-ID: <CAD7SSK6ScmCsp80mpDsnVHDwf0rK-vUahSqYzc7mRJ25kaKUcg__16826.2160769247$1377615803$gmane$org@mail.gmail.com>
References: <CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
	<20130824175909.GA12409@Krystal>
	<CAMaFG-2cJ+uGdwC5hHMBHUs+HBciaPXtYQ6YAkwan5bL9O=9Og@mail.gmail.com>
	<CAD7SSK7_sNYZE5knPEJuJwnj+OXmpcXg1EGGThnT4HW5+s5+KQ@mail.gmail.com>
	<20130826162407.1996f085@skate> <20130826151147.GA16659@Krystal>
	<CAD7SSK6FBSEyAzdAmq0Wfr8xyDt6vF9Na6TVdQh_GEUtqqPa6A@mail.gmail.com>
	<20130826151917.GA16924@Krystal> <20130826152759.GA17057@Krystal>
	<CAD7SSK47NJqbMUrcUPndfkgQPo2jik2FLmULm-vfj7SJFv9tjQ@mail.gmail.com>
	<20130826160038.GB17119@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1465937497=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jimmy.durand.wesolowski@gmail.com>)
	id 1VEKmn-0007nu-Av
	for lttng-dev@lists.lttng.org; Tue, 27 Aug 2013 11:02:30 -0400
Received: by mail-qc0-f171.google.com with SMTP id n1so2641185qcw.16
	for <lttng-dev@lists.lttng.org>; Tue, 27 Aug 2013 08:02:19 -0700 (PDT)
In-Reply-To: <20130826160038.GB17119@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1465937497==
Content-Type: multipart/alternative; boundary=001a11c2c0b8ce692a04e4ef288a

--001a11c2c0b8ce692a04e4ef288a
Content-Type: text/plain; charset=ISO-8859-1

2013/8/26 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> > 2013/8/26 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >
> > > I got it to work. See those commits in master:
> > >
> > Great, thank you.
> > I just got a little problem about libraries, and took only a chunk of my
> > patch
> > to correct it.
> > I also kept the --with-rcu-path (renamed from --with-rcu-prefix)
> configure
> > option, but if you do not like it, of course, feel free to remove it.
> > I will send this in a moment.
>
> Please make sure you detail your use-case (how to reproduce the issue)
> along with your patch.
>
> Thanks,
>

My mistake, I did a 'git clean' and retried, your last patches correct the
problem. Only my --with-rcu-path patch would be useful, but maybe not enough
to be put in the project.


Thank you,
-- 
Jimmy Durand Wesolowski
OpenWide R&D engineer
OneAccess

--001a11c2c0b8ce692a04e4ef288a
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr">2013/8/26 Mathieu Desnoyers <span dir="ltr">&lt;<a href="mailto:mathieu.desnoyers@efficios.com" target="_blank">mathieu.desnoyers@efficios.com</a>&gt;</span><br><div class="gmail_extra"><div class="gmail_quote">
<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class="im">* Jimmy Durand Wesolowski (<a href="mailto:jimmy.durand.wesolowski@gmail.com">jimmy.durand.wesolowski@gmail.com</a>) wrote:<br>

</div><div class="im">&gt; 2013/8/26 Mathieu Desnoyers &lt;<a href="mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
&gt;<br>
&gt; &gt; I got it to work. See those commits in master:<br>
&gt; &gt;<br>
&gt; Great, thank you.<br>
&gt; I just got a little problem about libraries, and took only a chunk of my<br>
&gt; patch<br>
&gt; to correct it.<br>
&gt; I also kept the --with-rcu-path (renamed from --with-rcu-prefix) configure<br>
&gt; option, but if you do not like it, of course, feel free to remove it.<br>
&gt; I will send this in a moment.<br>
<br>
</div>Please make sure you detail your use-case (how to reproduce the issue)<br>
along with your patch.<br>
<br>
Thanks,<br></blockquote><div><br></div><div>My mistake, I did a &#39;git clean&#39; and retried, your last patches correct the</div><div>problem. Only my --with-rcu-path patch would be useful, but maybe not enough</div><div>
to be put in the project.</div><div><br></div><div><br></div><div>Thank you,</div></div>-- <br><div dir="ltr">Jimmy Durand Wesolowski<br><div>OpenWide R&amp;D engineer<br></div><div>OneAccess</div></div>
</div></div>

--001a11c2c0b8ce692a04e4ef288a--


--===============1465937497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1465937497==--
