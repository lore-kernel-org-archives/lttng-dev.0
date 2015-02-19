From: Umut Tezduyar Lindskog <umut@tezduyar.com>
Subject: Re: Path for core dump
Date: Thu, 19 Feb 2015 08:49:56 +0100
Message-ID: <CAFKnvs5O7h4P-3TB+m4b64jV96SuZVPnFZ8CyvS+GLuUPQZexg__5525.36701220578$1424332309$gmane$org@mail.gmail.com>
References: <OFB56050E8.48E7632E-ON65257DF1.00192C9D-65257DF1.0019B94A@tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <umut@tezduyar.com>) id 1YOLsV-0000tf-Vj
 for lttng-dev@lists.lttng.org; Thu, 19 Feb 2015 02:50:37 -0500
Received: by iecrl12 with SMTP id rl12so7559991iec.2
 for <lttng-dev@lists.lttng.org>; Wed, 18 Feb 2015 23:50:26 -0800 (PST)
In-Reply-To: <OFB56050E8.48E7632E-ON65257DF1.00192C9D-65257DF1.0019B94A@tcs.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Venkata Kantimahanthi <venkata.kantimahanthi@tcs.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Venkata,

Coredumps are passed to the program that is specified with
/proc/sys/kernel/core_pattern. Depending on what program is defined,
you should retrieve the dump from there.

For example, if you had systemd, coredumps are passed to
systemd-coredump program and they can be viewed/retrieved with
coredumpctl.

Umut

On Thu, Feb 19, 2015 at 5:39 AM, Venkata Kantimahanthi
<venkata.kantimahanthi@tcs.com> wrote:
> Hi,
>
>  Once I have seen a crash in babeltrace, does any one know where to find the
> coredump? (I am running  BabelTrace Trace Viewer and Converter 1.2.1)
> babeltrace -i lttng-live net://127.0.0.1/host/du1/testF
> [error] No metadata stream opened
> Segmentation fault (core dumped)
>
>
> Thanks & Regards
> Venkata Ranganadh Kantimahanthi
> Tata Consultancy Services
> Cell:- +919494595225
> Mailto: venkata.kantimahanthi@tcs.com
> Website: http://www.tcs.com
> ____________________________________________
> Experience certainty.        IT Services
>                        Business Solutions
>                        Consulting
> ____________________________________________
>
> =====-----=====-----=====
> Notice: The information contained in this e-mail
> message and/or attachments to it may contain
> confidential or privileged information. If you are
> not the intended recipient, any dissemination, use,
> review, distribution, printing or copying of the
> information contained in this e-mail message
> and/or attachments to it are strictly prohibited. If
> you have received this communication in error,
> please notify us by reply e-mail or telephone and
> immediately and permanently delete the message
> and any attachments. Thank you
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
