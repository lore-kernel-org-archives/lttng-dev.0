From: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building patches.
Date: Mon, 26 Aug 2013 17:53:17 +0200
Message-ID: <CAD7SSK47NJqbMUrcUPndfkgQPo2jik2FLmULm-vfj7SJFv9tjQ__32406.3618820675$1377532457$gmane$org@mail.gmail.com>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125523.GB26852@Krystal>
	<CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
	<20130824175909.GA12409@Krystal>
	<CAMaFG-2cJ+uGdwC5hHMBHUs+HBciaPXtYQ6YAkwan5bL9O=9Og@mail.gmail.com>
	<CAD7SSK7_sNYZE5knPEJuJwnj+OXmpcXg1EGGThnT4HW5+s5+KQ@mail.gmail.com>
	<20130826162407.1996f085@skate> <20130826151147.GA16659@Krystal>
	<CAD7SSK6FBSEyAzdAmq0Wfr8xyDt6vF9Na6TVdQh_GEUtqqPa6A@mail.gmail.com>
	<20130826151917.GA16924@Krystal> <20130826152759.GA17057@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2053159477=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jimmy.durand.wesolowski@gmail.com>)
	id 1VDz6Z-0008Nk-Df
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 11:53:28 -0400
Received: by mail-qc0-f169.google.com with SMTP id k8so750548qcq.28
	for <lttng-dev@lists.lttng.org>; Mon, 26 Aug 2013 08:53:18 -0700 (PDT)
In-Reply-To: <20130826152759.GA17057@Krystal>
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

--===============2053159477==
Content-Type: multipart/alternative; boundary=047d7b677c7e3f02a404e4dbc132

--047d7b677c7e3f02a404e4dbc132
Content-Type: text/plain; charset=ISO-8859-1

2013/8/26 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> I got it to work. See those commits in master:
>
Great, thank you.
I just got a little problem about libraries, and took only a chunk of my
patch
to correct it.
I also kept the --with-rcu-path (renamed from --with-rcu-prefix) configure
option, but if you do not like it, of course, feel free to remove it.
I will send this in a moment.


Thank you,
-- 
Jimmy Durand Wesolowski
OpenWide R&D engineer
OneAccess

--047d7b677c7e3f02a404e4dbc132
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr">2013/8/26 Mathieu Desnoyers <span dir="ltr">&lt;<a href="mailto:mathieu.desnoyers@efficios.com" target="_blank">mathieu.desnoyers@efficios.com</a>&gt;</span><br><div class="gmail_extra"><div class="gmail_quote">
<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class="HOEnZb"><div class="h5"><span style="color:rgb(34,34,34)">I got it to work. See those commits in master:</span></div>
</div></blockquote><div>Great, thank you.</div><div>I just got a little problem about libraries, and took only a chunk of my patch</div><div>to correct it.</div><div>I also kept the --with-rcu-path (renamed from --with-rcu-prefix) configure</div>
<div>option, but if you do not like it, of course, feel free to remove it.</div><div>I will send this in a moment.</div><div><br></div><div><br></div></div><div>Thank you,</div>-- <br><div dir="ltr">Jimmy Durand Wesolowski<br>
<div>OpenWide R&amp;D engineer<br></div><div>OneAccess</div></div>
</div></div>

--047d7b677c7e3f02a404e4dbc132--


--===============2053159477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2053159477==--
