From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [PATCH lttv] Add build instructions for git tree
 pulls and use more standard formatting
Date: Mon, 19 Aug 2013 09:42:25 +0300
Message-ID: <OF8E71E2C5.84B3C9C6-ONC2257BCC.0024AB99-C2257BCC.0024CCB4__43106.828761711$1376894616$gmane$org@il.ibm.com>
References: <20130807194853.GA11032@ub8ca3a8c12a551e580d6.ant.amazon.com>
	<5203EC44.7070402@voxpopuli.im>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1238437113=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VBJAu-0007IF-I6
	for lttng-dev@lists.lttng.org; Mon, 19 Aug 2013 02:42:51 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Mon, 19 Aug 2013 07:37:30 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 345872190056
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 07:47:18 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r7J6gQ9U43188476
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 06:42:26 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r7J6gbvH009062
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 00:42:37 -0600
In-Reply-To: <5203EC44.7070402@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org, Vomlehn <vomlehnd@amazon.com>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1238437113==
Content-Type: multipart/alternative; boundary="=_alternative 0024CC68C2257BCC_="

This is a multipart message in MIME format.
--=_alternative 0024CC68C2257BCC_=
Content-Type: text/plain; charset="US-ASCII"

I thouhght that's what the 'bootstrap' script is for. I mean - it includes 
autoreconf -i plus creation of config directory... So maybe the doc should 
say "use the bootstrap script" instead of calling users to run autoreconf 
-i ...

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Alexandre Montplaisir <alexmonthy@voxpopuli.im>
To:     lttng-dev@lists.lttng.org
Cc:     Vomlehn <vomlehnd@amazon.com>
Date:   08/08/2013 10:08 PM
Subject:        Re: [lttng-dev] [PATCH lttv] Add build instructions for 
git tree pulls and use more standard formatting



On 13-08-07 03:48 PM, Vomlehn wrote:
> If the source is obtained directly from git, the file "configure" must 
be
> built with the autoconf tools. In addition, example shell commands are
> traditionally preceeded with a "$" instead of a "-", so this convention
> is used.
> ---
>  README |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/README b/README
> index 98849b3..ac28f9e 100644
> --- a/README
> +++ b/README
> @@ -31,9 +31,16 @@ libc6 development librairies
> 
>  To compile the source tree from a tarball, simply follow these steps :
> 
> -- ./configure
> -- make
> -- make install
> +  $ ./configure
> +  $ make
> +  $ make install
> +
> +To compile the source tree from a git checkout, use:
> +
> +  $ autoreconf
> +  $ automake --add-missing --gnu

You should be able to use "autoreconf -i" instead of those two commands.
It avoids the need to run autoconf, automake etc. manually.

> +  $ make
> +  $ make install

As was mentioned in the other thread, this should be "# make install",
since with the default configure options, it will install in /usr/local,
and only root can write there.

Cheers,
Alex

> 
>  After running ./configure, you can also go in specific subdirectories 
and
>  use make, make install.


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--=_alternative 0024CC68C2257BCC_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">I thouhght that's what the 'bootstrap'
script is for. I mean - it includes autoreconf -i plus creation of config
directory... So maybe the doc should say &quot;use the bootstrap script&quot;
instead of calling users to run autoreconf -i ...</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Alexandre Montplaisir
&lt;alexmonthy@voxpopuli.im&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Vomlehn &lt;vomlehnd@amazon.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">08/08/2013 10:08 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
[PATCH lttv] Add build instructions for git tree pulls and use more standard
formatting</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>On 13-08-07 03:48 PM, Vomlehn wrote:<br>
&gt; If the source is obtained directly from git, the file &quot;configure&quot;
must be<br>
&gt; built with the autoconf tools. In addition, example shell commands
are<br>
&gt; traditionally preceeded with a &quot;$&quot; instead of a &quot;-&quot;,
so this convention<br>
&gt; is used.<br>
&gt; ---<br>
&gt; &nbsp;README | &nbsp; 13 ++++++++++---<br>
&gt; &nbsp;1 file changed, 10 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/README b/README<br>
&gt; index 98849b3..ac28f9e 100644<br>
&gt; --- a/README<br>
&gt; +++ b/README<br>
&gt; @@ -31,9 +31,16 @@ libc6 development librairies<br>
&gt; &nbsp;<br>
&gt; &nbsp;To compile the source tree from a tarball, simply follow these
steps :<br>
&gt; &nbsp;<br>
&gt; -- ./configure<br>
&gt; -- make<br>
&gt; -- make install<br>
&gt; + &nbsp;$ ./configure<br>
&gt; + &nbsp;$ make<br>
&gt; + &nbsp;$ make install<br>
&gt; +<br>
&gt; +To compile the source tree from a git checkout, use:<br>
&gt; +<br>
&gt; + &nbsp;$ autoreconf<br>
&gt; + &nbsp;$ automake --add-missing --gnu<br>
<br>
You should be able to use &quot;autoreconf -i&quot; instead of those two
commands.<br>
It avoids the need to run autoconf, automake etc. manually.<br>
<br>
&gt; + &nbsp;$ make<br>
&gt; + &nbsp;$ make install<br>
<br>
As was mentioned in the other thread, this should be &quot;# make install&quot;,<br>
since with the default configure options, it will install in /usr/local,<br>
and only root can write there.<br>
<br>
Cheers,<br>
Alex<br>
<br>
&gt; &nbsp;<br>
&gt; &nbsp;After running ./configure, you can also go in specific subdirectories
and<br>
&gt; &nbsp;use make, make install.<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
<br>
</font></tt>
<br>
--=_alternative 0024CC68C2257BCC_=--



--===============1238437113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1238437113==--
