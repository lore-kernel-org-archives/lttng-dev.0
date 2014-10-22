From: "Boisvert, Sebastien" <boisvert@anl.gov>
Subject: Re: Padding with Fs in babeltrace for a 32 bits field
 (ctf_integer_hex)
Date: Wed, 22 Oct 2014 21:31:57 +0000
Message-ID: <E949C1E351B4914B87A26A5F96E06A9286B387__422.548087272112$1414013585$gmane$org@PAYTON.anl.gov>
References: <E949C1E351B4914B87A26A5F96E06A9286B328@PAYTON.anl.gov>,
 <CAB4xu_3NMhkgL8AsVC7o65sVByYutuNoRu0WvzL+UKMOzsU7ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailrelay.anl.gov ([130.202.101.22])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <boisvert@anl.gov>) id 1Xh3Vj-00058P-Iw
 for lttng-dev@lists.lttng.org; Wed, 22 Oct 2014 17:32:09 -0400
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTP id 222BA7CC167
 for <lttng-dev@lists.lttng.org>; Wed, 22 Oct 2014 16:31:58 -0500 (CDT)
In-Reply-To: <CAB4xu_3NMhkgL8AsVC7o65sVByYutuNoRu0WvzL+UKMOzsU7ag@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> ________________________________________
> From: Philippe Proulx [eeppeliteloop@gmail.com]
> Sent: Wednesday, October 22, 2014 4:03 PM
> To: Boisvert, Sebastien
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Padding with Fs in babeltrace for a 32 bits field (ctf_integer_hex)
> On Wed, Oct 22, 2014 at 4:34 PM, Boisvert, Sebastien <boisvert@anl.gov> wrote:
> > I am using LTTng-UST (lttng 2.4.1-1.el6) and babeltrace (1.2.1-1.el6) on CentOS 6.5 (using EPEL).
> >
> > I have 2 hexadecimal fields:
> >
> >       ctf_integer_hex(int, script, actor->script->identifier)
> >       ctf_integer_hex(int, action, message->action)
> >
> > One of them is printed with leading Fs (64 bits) while the other is fine (32 bits), but both should be 32 bits wide.
> >
> > [14:52:27.416502837] (+0.000005124) silverclaw.novalocal thorium_actor:receive_exit: { cpu_id = 6 }, { name = 1000452, script = 0xFFFFFFFFEB3B39FD, action = 0x7724, count = 41 }
> >
> > I expect "script = 0xEB3B39FD" and not script = 0xFFFFFFFFEB3B39FD since this is a int (sizeof(int) is 4).
> The issue is on the Babeltrace's ctf-text format side. When printing an
> integer with base 16 (ctf_integer_hex()):
> formats/ctf-text/types/integer.c:111:
>     case 16:
>     {
>         uint64_t v;
>         if (!integer_declaration->signedness)
>             v = integer_definition->value._unsigned;
>         else
>             v = (uint64_t) integer_definition->value._signed;
>         fprintf(pos->fp, "0x%" PRIX64, v);
>         break;
>     }
> When the integer is signed, it's casted to a 64-bit unsigned integer,
> hence the visible sign extension (all those Fs) in your case since the
> actual recorded value is -348440067 (if I'm still good at mental two's
> complement conversions ;-)).
> I believe this choice in Babeltrace is okay. It's always weird to
> represent a signed integer in hex base. How would you print it?

The script identifier is found here:
[boisvert@bigmem biosal]$ grep 39fd genomics/* -R
genomics/assembly/unitig/unitig_visitor.h:#define SCRIPT_UNITIG_VISITOR 0xeb3b39fd

I would just print as it is: 0xeb3b39fd

$ cat foo.c 

#include <stdio.h>
#define SCRIPT_UNITIG_VISITOR 0xeb3b39fd

int main(int argc, char **argv)
{
    int script;
    script = SCRIPT_UNITIG_VISITOR;
    printf("0x%x\n", script);

    return 0;
}
$ gcc foo.c 
$ ./a.out 
0xeb3b39fd


> -0x14C4C603? I guess this would work too and could eventually be a
> format option passed to Babeltrace.
> Hope it helps, somehow,
> Phil
> >
> > Am I doing something wrong ?
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
