From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH/babeltrace] Fix babeltrace-log crash
Date: Fri, 7 Sep 2012 09:18:07 -0400
Message-ID: <20120907131807.GC22377__32771.7020795264$1347023918$gmane$org@Krystal>
References: <CANFwon2TVvTO9NLVcFfTMJphLCoXp1p1F_Gfgioez+2xLnoBpw@mail.gmail.com>
	<20120907123748.GB22241@Krystal>
	<CANFwon326SuTBHxAM0FAupcGkwSxvgsX5mr4U8-xpyQOhw8TPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T9yRl-0007Wi-7T
	for lttng-dev@lists.lttng.org; Fri, 07 Sep 2012 09:18:09 -0400
Content-Disposition: inline
In-Reply-To: <CANFwon326SuTBHxAM0FAupcGkwSxvgsX5mr4U8-xpyQOhw8TPg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hui Zhu <teawater@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Hui Zhu (teawater@gmail.com) wrote:
> On Fri, Sep 7, 2012 at 8:37 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > * Hui Zhu (teawater@gmail.com) wrote:
> >> Hi,
> >>
> >> Got a crash with babeltrace-log.
> >>
> >> #0  0x00007ffff744504c in free () from /lib/x86_64-linux-gnu/libc.so.6
> >> #1  0x00007ffff7ba6fc9 in munmap_align (mma=0x7ffff7ffe620) at
> >> ../../../babeltrace/include/babeltrace/mmap-align.h:78
> >> #2  0x00007ffff7ba82db in ctf_packet_seek (stream_pos=0x7fffffffde60,
> >> index=0, whence=0)
> >>     at ../../../babeltrace/formats/ctf/ctf.c:623
> >> #3  0x00007ffff7ba8141 in ctf_init_pos (pos=0x7fffffffde60, fd=8, open_flags=2)
> >>     at ../../../babeltrace/formats/ctf/ctf.c:576
> >> #4  0x0000000000401146 in trace_text (output=8, input=0x7ffff7779340
> >> <_IO_2_1_stdin_>)
> >>     at ../../babeltrace/converter/babeltrace-log.c:233
> >> #5  main (argc=<optimized out>, argv=<optimized out>) at
> >> ../../babeltrace/converter/babeltrace-log.c:342
> >>
> >> This issue because pos is used before it init.  This patch init it in
> >> function ctf_init_pos.
> >
> > Merged as:
> >
> >
> > commit 36741bea2b53007c29ac0391ee9086722e00653a
> > Author: Hui Zhu <teawater@gmail.com>
> > Date:   Fri Sep 7 08:36:28 2012 -0400
> >
> >     Fix babeltrace-log uninitialized memory
> >
> >     Got a crash with babeltrace-log.
> >
> >     ../../../babeltrace/include/babeltrace/mmap-align.h:78
> >     index=0, whence=0)
> >         at ../../../babeltrace/formats/ctf/ctf.c:623
> >         at ../../../babeltrace/formats/ctf/ctf.c:576
> >     <_IO_2_1_stdin_>)
> >         at ../../babeltrace/converter/babeltrace-log.c:233
> >     ../../babeltrace/converter/babeltrace-log.c:342
> >
> >     This issue because pos is used before it init.  This patch init it in
> >     function ctf_init_pos.
> >
> >     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >
> > Thanks!
> >
> > Mathieu
> 
> Hi Mathieu,
> 
> The first one will make babeltrace crash.
> Please revert it and use the second one.

Done, thanks,

Mathieu

> 
> Thanks,
> Hui
> 
> >
> >
> >>
> >> Thanks,
> >> Hui
> >>
> >> --- a/formats/ctf/ctf.c
> >> +++ b/formats/ctf/ctf.c
> >> @@ -550,6 +550,7 @@ error:
> >>
> >>  void ctf_init_pos(struct ctf_stream_pos *pos, int fd, int open_flags)
> >>  {
> >> +     memset(pos, 0, sizeof(*pos));
> >>       pos->fd = fd;
> >>       if (fd >= 0) {
> >>               pos->packet_cycles_index = g_array_new(FALSE, TRUE,
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> > --
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com

> --- a/converter/babeltrace-log.c
> +++ b/converter/babeltrace-log.c
> @@ -230,6 +230,7 @@ void trace_text(FILE *input, int output)
>  	char *line = NULL, *nl;
>  	size_t linesize;
>  
> +	memset(&pos, 0, sizeof(pos));
>  	ctf_init_pos(&pos, output, O_RDWR);
>  
>  	write_packet_header(&pos, s_uuid);

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
