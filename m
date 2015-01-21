From: Wang Nan <wangnan0@huawei.com>
Subject: Re: Fwd: perf data convert error
Date: Wed, 21 Jan 2015 09:45:30 +0800
Message-ID: <54BF04BA.7080406__28363.9883077287$1421806855$gmane$org@huawei.com>
References: <CAGfiMvBRRRGRJdgkQpubc4BUTeh3m43tFGtCiz1nshjTzikFkg@mail.gmail.com>
 <CAGfiMvA6+P0MeBCFH16BA4j0BHRvWw+baGWc=q_JC-pWVgndQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wangnan0@huawei.com>) id 1YDkNO-0005le-0w
 for lttng-dev@lists.lttng.org; Tue, 20 Jan 2015 20:46:37 -0500
In-Reply-To: <CAGfiMvA6+P0MeBCFH16BA4j0BHRvWw+baGWc=q_JC-pWVgndQw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Divya Vyas <edivya.vyas@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2015/1/20 20:15, Divya Vyas wrote:
> ---------- Forwarded message ----------
> From: Divya Vyas <edivya.vyas@gmail.com>
> Date: Tue, Jan 20, 2015 at 5:17 PM
> Subject: perf data convert error
> To: LKML <linux-kernel@vger.kernel.org>
> 
> 
> Hi,
> 
> 
> I am getting one error while converting the perf.data to CTF format .
> 
> 
> ./perf data convert -i perf.data --to-ctf dv_ctf
> ./perf: symbol lookup error: ./perf: undefined symbol:
> bt_ctf_stream_class_get_packet_context_type
> 
> While I created perf binary and below is the output :
> 
> make DEBUG=1 LIBBABELTRACE_DIR=/opt/libbabeltrace/
>   BUILD:   Doing 'make -j4' parallel build
> config/Makefile:139: The path 'python-config' is not executable.
> config/Makefile:507: Missing perl devel files. Disabling perl
> scripting support, consider installing perl-ExtUtils-Embed
> config/Makefile:538: No python-config tool was found
> config/Makefile:538: Python support will not be built
> config/Makefile:610: No bfd.h/libbfd found, install
> binutils-dev[el]/zlib-static to gain symbol demangling
> 
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...                         glibc: [ on  ]
> ...                          gtk2: [ on  ]
> ...                      libaudit: [ on  ]
> ...                        libbfd: [ OFF ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ on  ]
> ...                       libperl: [ OFF ]
> ...                     libpython: [ OFF ]
> ...                      libslang: [ on  ]
> ...                     libunwind: [ on  ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                 libbabeltrace: [ on  ]
> ...                          zlib: [ on  ]
> ...     DWARF post unwind library: libunwind
> 

Have you installed your libbabeltrace shared libraries properly?
Looks like libraries you used for compiling and for execution are different.

Try 'ldd perf' and you should find something like:

$ ldd /path/to/perf
	...
	libbabeltrace-ctf.so.1 => /path/to/libbabeltrace-ctf.so.1 (0x00007f312c861000)
	...

then nm:

$ nm /path/to/libbabeltrace-ctf.so.1 | grep bt_ctf_stream_class_get_packet_context_type
000000000002b3f0 T bt_ctf_stream_class_get_packet_context_type

If you don't get that symbol you should update your libbabeltrace runtime libraries.
