From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Test if tracepoint is enabled
Date: Fri, 7 Dec 2012 09:09:50 +0100
Message-ID: <50C1A44E.9000408__28622.6934324533$1354867803$gmane$org@mentor.com>
References: <50B43D06.7020709@quantum.com> <20121203143421.GA4458@Krystal>
	<50BD3499.3000509@quantum.com> <20121204140244.GA5298@Krystal>
	<50BE8FF9.5010807@quantum.com> <20121205101919.GA29447@Krystal>
	<50BFF294.50508@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1Tgszw-0007Fr-2E
	for lttng-dev@lists.lttng.org; Fri, 07 Dec 2012 03:09:28 -0500
In-Reply-To: <50BFF294.50508@quantum.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Bryant <david.bryant@quantum.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 12/06/2012 02:19 AM, David Bryant wrote:
> statement-expression would also work. Are we conflating separate ideas -
> the idea of user conditions and the idea of setup/cleanup?

FWIW, tracepoint_cond could be implemented as loan pattern (in pseudocode):

with_tp( provider, name, REF ) {
  if (cond) {
     // pre emit code block
     ...

     emit_REF( arg0, ... );

     // post emit code block
     ...
  }
}

This could even be nested. E.g.

with_tp( provider1, nameA, REF1 ) {
  with_tp( provider2, nameB, REF2 ) {
    if (cond) {
       // pre emit code block if both are enabled
       ...

       emit_REF1( arg0x, ... );
       emit_REF2( arg0y, ... );

       // post emit code block if both are enabled
       ...
    }
  }
}

Nesting would be rather unpleasant with the proposed
tracepoint_cond(provider, name, pre, post, ...).

--
Paul

> =

>> While we are there, it would be good to make the "pre" handler test a
>> condition. For your use-case, you would just have to pass a pre :
>>
>>   { printf("pre\n");  a =3D malloc(16); 1; }
>>
>> So we could do:
>>
>>     if (pre)
>>          __tracepoint_cb_##provider##___##name(__VA_ARGS__);
>>     (post)
>>
>> and therefore support not only to setup something, but also to add an
>> extra check on whether tracing should be skipped or not. If someone
>> passes "1" as end of the compound statement, it will always evaluate to
>> 1, and therefore the compiler will remove any extra branch in -O2.
>>
>> One question stands though: how would we integrate this with sdt.h
>> STAP_PROVEV() ?
> I'm yet to look at this.
> =

> Thanks,
> Dave
> =

> ----------------------------------------------------------------------
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

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject
to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and
other countries.
