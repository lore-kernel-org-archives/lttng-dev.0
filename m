From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Ctf specification on Variants and Enums
Date: Thu, 5 Dec 2013 22:33:33 +0000 (UTC)
Message-ID: <1324589346.80578.1386282813577.JavaMail.zimbra__28891.7131293148$1386282897$gmane$org@efficios.com>
References: <52A0FC00.8070706@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VohUd-0003R0-OX
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 17:34:08 -0500
In-Reply-To: <52A0FC00.8070706@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Matthew Khouzam" <matthew.khouzam@ericsson.com>
> To: lttng-dev@lists.lttng.org
> Sent: Thursday, December 5, 2013 11:19:44 PM
> Subject: [lttng-dev] Ctf specification on Variants and Enums
> 
> Hi,
> In the ctf specifications variants need a tag that is an enum. An enum
> can have identifiers as Strings. The enum can contain strings.
> 
> so if you have an enum:int32{"a","b","c", d} tag;
> and a variant <tag> { int "a"; int "b"... } according to the spec it

you need:

variant <tag> { int a; int b; }

with field names, no double quotes.

> should be fine.
> according to the test cases it fails.
> 
> Please clarify where my logic went astray.
> 
> Also, in reading the spec, there are no guaranties that enums contain
> ANY values of the fields of the variants. I think this is problematic
> 
> enum { a,b,c}
> variant{
> x,y,z} passes.

Yes, it does pass. It will produce errors at stream read if an enum
chosen does not match what is available in the variant. I thought about this
yesterday (being restrictive or accepting in mapping between variant and
enum), and I ended up realizing that some use-cases could re-use the same
enum type with many variants, and we can have extra enum entries used for
other purposes than the variant the enum is used by, so basically, we
cannot really enforce to have a full mapping 1 to 1 without restricting
some usage. Therefore, I went down the road to only check at stream read
if the stream contains enum values that do not map to a variant field, and
error out at that point. Not at metadata parsing.

Thanks,

Mathieu

> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
