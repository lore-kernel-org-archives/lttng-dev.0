From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: What is the size overhead of UST
 tracepoints?	(hint: very large indeed)
Date: Wed, 30 Oct 2013 09:38:17 +0200
Message-ID: <OFE5AAD6E5.2F4966C2-ONC2257C14.0029CBA5-C2257C14.0029F24D__24855.9262407527$1383118842$gmane$org@il.ibm.com>
References: <OF98A3476E.B164A434-ONC2257C13.003269EB-C2257C13.00354EB7@il.ibm.com>
	<A651D048-3BA0-419E-9A6A-9EDED86ED34C@demoninsight.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0123163925=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VbQNg-0003aU-3x
	for lttng-dev@lists.lttng.org; Wed, 30 Oct 2013 03:39:59 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 30 Oct 2013 07:39:47 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
	(d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0A4E717D8059
	for <lttng-dev@lists.lttng.org>; Wed, 30 Oct 2013 07:39:19 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r9U7cHuF56295634
	for <lttng-dev@lists.lttng.org>; Wed, 30 Oct 2013 07:38:17 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r9U7cTCD023705
	for <lttng-dev@lists.lttng.org>; Wed, 30 Oct 2013 01:38:29 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r9U7cTBx023699
	for <lttng-dev@lists.lttng.org>; Wed, 30 Oct 2013 01:38:29 -0600
In-Reply-To: <A651D048-3BA0-419E-9A6A-9EDED86ED34C@demoninsight.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Vlad <vlad@demoninsight.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0123163925==
Content-Type: multipart/alternative; boundary="=_alternative 0029F1E4C2257C14_="

This is a multipart message in MIME format.
--=_alternative 0029F1E4C2257C14_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Thanks for the suggestions. I am indeed going in a similar direction.

Nonetheless, I still think the we as a community of people who care about 
LTTng itself, should push for improving its memory footprint where 
possible.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Vlad <vlad@demoninsight.com>
To:     lttng-dev <lttng-dev@lists.lttng.org>
Date:   10/29/2013 04:34 PM
Subject:        Re: [lttng-dev] What is the size overhead of UST 
tracepoints?    (hint: very large indeed)




On Oct 29, 2013, at 4:42 AM, Amit Margalit <AMITM@il.ibm.com> wrote:

Additionally, there is a ton of code to calculate the event size, its 
alignment, and to verify that the names are not longer than the 256 byte 
buffer, and more. 

A couple of thoughts:

(a) there may be a way to share fewer definitions of events across more 
event emit sites. Especially if LTTng supported optional/missing fields :) 
For example, define a single "function.entry" and a single "function.exit" 
instead of a unique definition for each function you have. Disambiguate 
using a parameter.

(b) this is not something that could be done in kernel but in a C++ user 
app it's fairly easy to statically compute everything that depends on 
information known at compile time. I use a custom EDSL implemented via 
boost.proto. As a result, only the stuff that gets used is embedded in 
object code and all event emit calls inline in very fast assembly that's 
optimal for each particular combination of actual argument values.

Cheers,
Vlad_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 0029F1E4C2257C14_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Thanks for the suggestions. I am indeed
going in a similar direction.</font>
<br>
<br><font size=2 face="sans-serif">Nonetheless, I still think the we as
a community of people who care about LTTng itself, should push for improving
its memory footprint where possible.</font>
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
&nbsp;</font><font size=1 face="sans-serif">Vlad &lt;vlad@demoninsight.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev &lt;lttng-dev@lists.lttng.org&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">10/29/2013 04:34 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
What is the size overhead of UST tracepoints? &nbsp; &nbsp; &nbsp; &nbsp;(hint:
very large indeed)</font>
<br>
<hr noshade>
<br>
<br>
<br>
<br><font size=3>On Oct 29, 2013, at 4:42 AM, Amit Margalit &lt;</font><a href=mailto:AMITM@il.ibm.com><font size=3 color=blue><u>AMITM@il.ibm.com</u></font></a><font size=3>&gt;
wrote:</font>
<br>
<br><font size=2 face="sans-serif">Additionally, there is a ton of code
to calculate the event size, its alignment, and to verify that the names
are not longer than the 256 byte buffer, and more.</font><font size=3>
</font>
<br>
<br><font size=3>A couple of thoughts:</font>
<br>
<br><font size=3>(a) there may be a way to share fewer definitions of events
across more event emit sites. Especially if LTTng supported optional/missing
fields :) For example, define a single &quot;function.entry&quot; and a
single &quot;function.exit&quot; instead of a unique definition for each
function you have. Disambiguate using a parameter.</font>
<br>
<br><font size=3>(b) this is not something that could be done in kernel
but in a C++ user app it's fairly easy to statically compute everything
that depends on information known at compile time. I use a custom EDSL
implemented via boost.proto. As a result, only the stuff that gets used
is embedded in object code and all event emit calls inline in very fast
assembly that's optimal for each particular combination of actual argument
values.</font>
<br>
<br><font size=3>Cheers,</font>
<br><font size=3>Vlad</font><tt><font size=2>_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
</font></tt>
<br>
--=_alternative 0029F1E4C2257C14_=--



--===============0123163925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0123163925==--
