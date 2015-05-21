From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: lttng function tracing nginx problem
Date: Wed, 20 May 2015 22:32:27 -0400
Message-ID: <555D43BB.4050906__41332.5816778981$1432175673$gmane$org@voxpopuli.im>
References: <SNT146-W4B20B8ED37731C883223FB8C20@phx.gbl>,
 <638476085.4659.1432139321124.JavaMail.zimbra@efficios.com>
 <SNT146-W298EB3CDE57BAF7044769B8C10@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YvGHi-0003HZ-4K
 for lttng-dev@lists.lttng.org; Wed, 20 May 2015 22:32:38 -0400
In-Reply-To: <SNT146-W298EB3CDE57BAF7044769B8C10@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: gang li <portlet@outlook.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Is it possible that nginx forks other processes, and the main process 
stays there doing almost nothing? In such a case, you would need to also 
preload "liblttng-ust-fork.so", so that UST can follow through fork() 
calls. See the section USING LTTNG UST WITH DAEMONS of "man lttng-ust".

Cheers,
Alexandre


On 2015-05-20 09:02 PM, gang li wrote:
>
> [quehan@localhost objs]$ file ./nginx
> ./nginx: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, BuildID[sha1]=0xb7659abd6bd962b7033f3cc495ac8bb44ac9f044, not stripped
>
>
>
> CFLAGS = -finstrument-functions -pipe -W -Wall -Wpointer-arith -Wno-unused-parameter -Werror -g
> [quehan@localhost objs]$ nm ./nginx | grep __cyg_profile_func                 U __cyg_profile_func_enter@@GLIBC_2.2.5
>
>
>                   U __cyg_profile_func_exit@@GLIBC_2.2.5
> [quehan@localhost objs]$ cat /proc/2046/maps | grep lttng7f2298000000-7f2298009000 r-xp 00000000 fd:01 103870944                  /usr/lib/liblttng-ust-tracepoint.so.0.0.07f2298009000-7f2298208000 ---p 00009000 fd:01 103870944                  /usr/lib/liblttng-ust-tracepoint.so.0.0.07f2298208000-7f2298209000 r--p 00008000 fd:01 103870944                  /usr/lib/liblttng-ust-tracepoint.so.0.0.07f2298209000-7f229820a000 rw-p 00009000 fd:01 103870944                  /usr/lib/liblttng-ust-tracepoint.so.0.0.07f2298aaa000-7f2298af2000 r-xp 00000000 fd:01 103870951                  /usr/lib/liblttng-ust.so.0.0.07f2298af2000-7f2298cf2000 ---p 00048000 fd:01 103870951                  /usr/lib/liblttng-ust.so.0.0.07f2298cf2000-7f2298cf4000 r--p 00048000 fd:01 103870951                  /usr/l
 ib/liblttng-ust.so.0.0.07f2298cf4000-7f2298cf9000 rw-p 0004a000 fd:01 103870951                  /usr/lib/liblttng-ust.so.0.0.07f2299d6a000-7f2299d6c000 r-xp 00000000 fd:01 103870981       !
            /usr/lib/liblttng-ust-cyg-profile-fast.so.0.0.07f2299d6c000-7f2299f6c000 ---p 00002000 fd:01 103870981                  /usr/lib/liblttng-ust-cyg-profile-fast.so.0.0.07f2299f6c000-7f2299f6d000 r--p 00002000 fd:01 103870981                  /usr/lib/liblttng-ust-cyg-profile-fast.so.0.0.07f2299f6d000-7f2299f6e000 rw-p 00003000 fd:01 103870981                  /usr/lib/liblttng-ust-cyg-profile-fast.so.0.0.07f229a18a000-7f229a18b000 r--s 00000000 00:11 18728                      /dev/shm/lttng-ust-wait-5-1000
>
>
>
>
>
> 7f229a18b000-7f229a18c000 r--s 00000000 00:11 18727                      /dev/shm/lttng-ust-wait-5
>
> Nginx is a very famous lightweight http server, and I use the latest lttng suits, I can't resolve this.
>
> Date: Wed, 20 May 2015 16:28:41 +0000
> From: mathieu.desnoyers@efficios.com
> To: portlet@outlook.com
> CC: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] lttng function tracing nginx problem
>
>
> hi all,
> I compile the nginx-1.4.7 with FLAG -finstrument-functions , and start nginx like this:
> LD_PRELOAD=liblttng-ust-cyg-profile-fast.so  ./nginx
> Then I use the command lttng list --userspace and got nothing like this:
> UST events:-------------None
> I don't understand why I can't get the func_exit/entry events from nginx.
> Is the "ngix" executable a binary executable or a shell script ?
>
> Can you give us the output of "file ./ngix" ?
>
> You might want to try
>
> export LD_PRELOAD=liblttng-ust-cyg-profile-fast.so
> ./ngix
>
> Thanks,
>
> Mathieu
>
>
>
> By the way, I test function tracing with a single c source file and works well, output like this:
> UST events:-------------
> PID: 4687 - Name: ./tt      lttng_ust_cyg_profile:func_exit (loglevel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)      lttng_ust_cyg_profile:func_entry (loglevel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)      lttng_ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type: tracepoint)
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>        ust_baddr_statedump:soinfo (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
>
> Wishing for help.
