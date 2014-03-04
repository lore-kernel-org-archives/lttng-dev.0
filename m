From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: LTTng-UST and "ip" context
Date: Tue, 4 Mar 2014 09:25:48 +0100
Message-ID: <53158E0C.10102__4924.5840091773$1393921719$gmane$org@mentor.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB2A67A5D3@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1WKkhX-0005U4-RR
	for lttng-dev@lists.lttng.org; Tue, 04 Mar 2014 03:27:53 -0500
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB2A67A5D3@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi David,

On 03/03/2014 11:24 PM, David OShea wrote:
> Hi all,
> =

>  =

> =

> Apologies if this is a stupid question, but is the =93ip=94 context meant=
 to
> be used with LTTng-UST?  I tried it out, and the address in the field
> pointed to the TRACEPOINT_EVENT definition in my header file, i.e. not
> to the tracepoint() call site.  Could this be due to the fact that I use

That's most likely a side effect of having debug info with macro
expansion (e.g. caused by compiling with -g3).

See: GCC info pages:

     Level 3 includes extra information, such as all the macro
     definitions present in the program.  Some debuggers support macro
     expansion when you use `-g3'.

Use 'addr2line -i' if you want to see where the TRACEPOINT_EVENT macro
was expanded instead of the definition of the macro itself:

       -i
       --inlines
           If the address belongs to a function that was inlined, the
           source information for all enclosing scopes back to the
           first non-inlined function will also be printed. ....


For example:

addr2line -e $PREFIX/bin/test 400ee6
/home/pwoegere/test/test_tracepoint.h:18

With -i you get:

addr2line -i -e $PREFIX/bin/test 400ee6
/home/pwoegere/test/test_tracepoint.h:18
/home/pwoegere/test/test.c:15 <-- That's what you want !


HTH,
Paul


> dynamic trace providers, could it be due to my compile options, or is
> this only meant for kernel tracing?
> =

>  =

> =

> This is with the following (with some minor patches, so admittedly it
> could be my fault) on CentOS 6:
> =

> babeltrace-1.1.2
> =

> lttng-tools-2.3.2
> =

> lttng-ust-2.3.2
> =

> userspace-rcu-0.8.3
> =

>  =

> =

> Thanks in advance,
> David
> =

> ------------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any
> disclosure, copying, or further distribution of confidential information
> is not permitted unless such privilege is explicitly granted in writing
> by Quantum. Quantum reserves the right to have electronic
> communications, including email and attachments, sent across its
> networks filtered through anti virus and spam software programs and
> retain such messages in order to comply with applicable data security
> and retention requirements. Quantum is not responsible for the proper
> and complete transmission of the substance of this communication or for
> any delay in its receipt.
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =



-- =

Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
