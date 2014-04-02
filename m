From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Minor documentation issue with 2.4.0
Date: Wed, 2 Apr 2014 10:48:02 -0400
Message-ID: <CA+jJMxvOS8zo4msc_WMcrO9F=FkVbF4RwkueuKeL=jnjWQRHHQ__32677.3185086951$1396525931$gmane$org@mail.gmail.com>
References: <OF651759A2.C8A68066-ONC2257CAE.00334115-C2257CAE.0033A0AF@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WVMSW-0000XY-H0
 for lttng-dev@lists.lttng.org; Wed, 02 Apr 2014 10:48:16 -0400
Received: by mail-qg0-f49.google.com with SMTP id e89so296580qgf.22
 for <lttng-dev@lists.lttng.org>; Wed, 02 Apr 2014 07:48:02 -0700 (PDT)
In-Reply-To: <OF651759A2.C8A68066-ONC2257CAE.00334115-C2257CAE.0033A0AF@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Amit,

Can you open a bug against lttng-tools on bugs.lttng.org? This way
we'll be sure to track the change.

Thanks,
J=E9r=E9mie

On Wed, Apr 2, 2014 at 5:23 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hello,
>
> I ran a command that included an error, and noticed that 'lttng' mentions=
 -j
> in --buffers-pid and --buffers-uid, but nowhere else:
>
> # /usr/bin/lttng enable-channel -u
> Error: Missing channel name.
>
> usage: lttng enable-channel NAME[,NAME2,...] (-u | -k) [OPTIONS]
>
> Options:
>   -h, --help               Show this help
>       --list-options       Simple listing of options
>   -s, --session NAME       Apply to session name
>   -k, --kernel             Apply to the kernel tracer
>   -u, --userspace          Apply to the user-space tracer
>
> Channel options:
>       --discard            Discard event when buffers are full (default)
>       --overwrite          Flight recorder mode
>       --subbuf-size SIZE   Subbuffer size in bytes {+k,+M,+G}
>                                (default UST uid: 131072, UST pid: 4096,
> kernel: 262144, metadata: 4096)
>                                Rounded up to the next power of 2.
>       --num-subbuf NUM     Number of subbufers
>                                (default UST uid: 4, UST pid: 4, kernel: 4,
> metadata: 2)
>                                Rounded up to the next power of 2.
>       --switch-timer USEC  Switch timer interval in usec
>                                (default UST uid: 0, UST pid: 0, kernel: 0,
> metadata: 0)
>       --read-timer USEC    Read timer interval in usec.
>                                (default UST uid: 0, UST pid: 0, kernel:
> 200000, metadata: 0)
>       --output TYPE        Channel output type (Values: mmap, splice)
>                                (default UST uid: mmap, UST pid: mmap,
> kernel: splice, metadata: mmap)
>       --buffers-uid        Use per UID buffer (-u/-j only)
>       --buffers-pid        Use per PID buffer (-u/-j only)
>       --buffers-global     Use shared buffer for the whole system (-k onl=
y)
>   -C, --tracefile-size SIZE
>                            Maximum size of each tracefile within a stream
> (in bytes). 0 means unlimited.
>                                (default: 0)
>   -W, --tracefile-count COUNT
>                            Used in conjunction with -C option, this will
> limit the number
>                            of files created to the specified count. 0 mea=
ns
> unlimited.
>                                (default: 0)
>
> Error: Command error
>
> You can see these 2 lines:
>
>       --buffers-uid        Use per UID buffer (-u/-j only)
>       --buffers-pid        Use per PID buffer (-u/-j only)
>
> But -j is not explained above.
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
