From: Jon Bernard <jbernard@tuxion.com>
Subject: Re: babeltrace test failures on some architectures
Date: Fri, 20 Jun 2014 11:14:10 -0400
Message-ID: <20140620151410.GA14065__11056.839352432$1403277302$gmane$org@helmut>
References: <20140604184126.GA26877@helmut>
 <CA+jJMxtn8XiLjT5NVURv5K8kECPPoPs1WF-0zTakJmRW=CO3mg@mail.gmail.com>
 <CAEzWAeLEvv8FbHfwq8=sMeDW49DjO_gKoZ99z1Ff9s+dR6GuJQ@mail.gmail.com>
 <20140609145201.GB25766@helmut>
 <CA+jJMxsuEtk3QdDz1_a0MOBq0To7wB4+QnOW3Rkp0uJZ1eM1gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@tuxion.com>) id 1Wy0W9-0008Um-F7
 for lttng-dev@lists.lttng.org; Fri, 20 Jun 2014 11:14:20 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6A1A22130F
 for <lttng-dev@lists.lttng.org>; Fri, 20 Jun 2014 11:14:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CA+jJMxsuEtk3QdDz1_a0MOBq0To7wB4+QnOW3Rkp0uJZ1eM1gw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com> wrote:
> The build logs only seem to contain the "prove" output (invoked by run.sh=
).
> =

> Could you run tests/bin/test_trace_read and
> tests/lib/test_seek_empty_packet on armel and sparc? The output of
> both of these tests and the coredumps (if any) should give me
> something to work with.

I had a short moment to run gdb on one of the offending tests on sparc,
here is the output:

    (gdb) run tests/ctf-traces/succeed/sequence
    Starting program: /home/jbernard/babeltrace/converter/.libs/lt-babeltra=
ce tests/ctf-traces/succeed/sequence
    [Thread debugging using libthread_db enabled]
    Using host libthread_db library "/lib/sparc-linux-gnu/libthread_db.so.1=
".

    Program received signal SIGBUS, Bus error.
    0xf7f78af4 in make_node (scanner=3D0x7001cfe0, type=3DNODE_UNARY_EXPRES=
SION) at ctf-parser.y:373
    373             node->lineno =3D yyget_lineno(scanner->scanner);
    (gdb) bt
    #0  0xf7f78af4 in make_node (scanner=3D0x7001cfe0, type=3DNODE_UNARY_EX=
PRESSION) at ctf-parser.y:373
    #1  0xf7f7a708 in yyparse (scanner=3D0x7001cfe0, yyscanner=3D0x7001c9c8=
) at ctf-parser.y:1202
    #2  0xf7f6a6a4 in ctf_trace_metadata_read (td=3D0x7001d600, metadata_fp=
=3D<optimized out>, scanner=3D0x7001cfe0, append=3D<optimized out>) at ctf.=
c:1281
    #3  0xf7f6f470 in ctf_open_trace_read (metadata_fp=3D0x0, packet_seek=
=3D0xf7f6cc60 <ctf_packet_seek>, flags=3D0, path=3D0x70026630 "tests/ctf-tr=
aces/succeed/sequence",
        td=3D0x7001d600) at ctf.c:2111
    #4  ctf_open_trace (path=3D0x70026630 "tests/ctf-traces/succeed/sequenc=
e", flags=3D0, packet_seek=3D0xf7f6cc60 <ctf_packet_seek>, metadata_fp=3D<o=
ptimized out>)
        at ctf.c:2206
    #5  0xf7fafba0 in bt_context_add_trace (ctx=3D0x7001b950, path=3D0x7002=
6630 "tests/ctf-traces/succeed/sequence", format_name=3D0x7001b990 "ctf", p=
acket_seek=3D0x0,
        stream_list=3D0x0, metadata=3D0x0) at context.c:95
    #6  0x70003468 in bt_context_add_traces_recursive (ctx=3D0x7001b950, pa=
th=3D0x7001b968 "tests/ctf-traces/succeed/sequence", format_str=3D0x7001b99=
0 "ctf",
        packet_seek=3D0x0) at babeltrace.c:529
    #7  0x70001ae8 in main (argc=3D<optimized out>, argv=3D<optimized out>)=
 at babeltrace.c:738

The scanner pointer and ctf_scanner struct appear to be okay, the bus
error appears to occur on scanner->scanner, which is of type yyscan_t.

I don't have time to look further at the moment, but I'll try next
chance I get.  Hope this helps.

Cheers,

-- =

Jon
