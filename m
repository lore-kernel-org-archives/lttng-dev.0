From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Teach babeltrace understand "native"
	and	"network" for byte_order
Date: Fri, 15 Mar 2013 10:33:37 -0400
Message-ID: <20130315143337.GA959__27855.4593366154$1363358074$gmane$org@Krystal>
References: <1363341137-26956-1-git-send-email-yao@codesourcery.com>
	<20130315120753.GA30973@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UGVhT-0001XW-22
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 10:33:39 -0400
Content-Disposition: inline
In-Reply-To: <20130315120753.GA30973@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yao Qi <yao@codesourcery.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Yao Qi (yao@codesourcery.com) wrote:
> > Hi,
> > We wrote byte_order in metadata either "le" or "be", according to the
> > host endianness.  Today, when I check the ctf specification, I find
> > "native" fits our needs well.  However, after I replace "le" with
> > "native" in metadata, I got the following error message:
> > 
> >   [error] get_trace_byte_order: unexpected string "native". Should be "native", "network", "be" or "le".
> > 
> > This patch teaches babeltrace understand "native" and "network".  With
> > this patch applied, the output looks right now.  Let me know if I need
> > run testsuite, and how.
> 
> your interpretation of what the byte order should accept is based on
> section 4.1.3 of the CTF spec, which discusses what byte order can be
> accepted by a type.
> 
> However, here you are proposing to change the byte order recognised at
> the trace declaration level. Unfortunately, we cannot assume anything
> about native endianness of the traced machine until we have the
> endianness information at the trace declaration level, as the trace can
> come from any source.
> 
> Possibly that the CTF spec would need to be clarified. Currently, we
> need to look at:
> 
> 7.4 TSDL Examples
> 
> trace {
>   ...
>   byte_order = be OR le;                        /* Endianness (required) */
>   ...
> };
> 
> to understand that only be and le should be expected in the trace
> description.
> 
> Thoughts ?

Clarified with CTF commit:

commit 7e58b8bfd86eea7b2929f2ee37dad7e167e11500
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Mar 15 10:31:37 2013 -0400

    Clarify trace byte_order
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/common-trace-format-specification.txt b/common-trace-format-specification.txt
index 1cd3c3d..4ab3ed9 100644
--- a/common-trace-format-specification.txt
+++ b/common-trace-format-specification.txt
@@ -181,6 +181,11 @@ TSDL meta-data representation:
 
   byte_order = native OR network OR be OR le;	/* network and be are aliases */
 
+Even though the trace description section is not per se a type, for sake
+of clarity, it should be noted that native and network byte orders are
+only allowed within type declaration. The byte_order specified in the
+trace description section only accepts be OR le values.
+
 4.1.4 Size
 
 Type size, in bits, for integers and floats is that returned by "sizeof()" in C

> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Signed-off-by: Yao Qi <yao@codesourcery.com>
> > ---
> >  .../ctf/metadata/ctf-visitor-generate-io-struct.c  |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
> > index 9bcc170..cea2877 100644
> > --- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
> > +++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
> > @@ -1227,6 +1227,10 @@ int get_trace_byte_order(FILE *fd, int depth, struct ctf_node *unary_expression)
> >  		byte_order = BIG_ENDIAN;
> >  	else if (!strcmp(unary_expression->u.unary_expression.u.string, "le"))
> >  		byte_order = LITTLE_ENDIAN;
> > +	else if (!strcmp(unary_expression->u.unary_expression.u.string, "native"))
> > +		byte_order = BYTE_ORDER;
> > +	else if (!strcmp(unary_expression->u.unary_expression.u.string, "network"))
> > +		byte_order = BIG_ENDIAN;
> >  	else {
> >  		fprintf(fd, "[error] %s: unexpected string \"%s\". Should be \"be\" or \"le\".\n",
> >  			__func__, unary_expression->u.unary_expression.u.string);
> > -- 
> > 1.7.7.6
> > 
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

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
