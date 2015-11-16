From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: URCU on the Xeon Phi
Date: Sun, 15 Nov 2015 22:31:47 -0500
Message-ID: <CAFXXi0mY1dfXiV5NJ5u_oG_r_YWhM8MRRqnNmD2gvSSJfKdPRg__16861.0744215131$1447644800$gmane$org@mail.gmail.com>
References: <571881.13bb3.150ff3ebc91.Coremail.sayounara@hnu.edu.cn>
 <96765675.96083.1447603240932.JavaMail.zimbra@efficios.com>
 <949605371.41173867.1447617490425.JavaMail.zimbra@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1ZyAWk-0003k7-9B
 for lttng-dev@lists.lttng.org; Sun, 15 Nov 2015 22:32:25 -0500
Received: by qkas77 with SMTP id s77so101828881qka.0
 for <lttng-dev@lists.lttng.org>; Sun, 15 Nov 2015 19:32:16 -0800 (PST)
In-Reply-To: <949605371.41173867.1447617490425.JavaMail.zimbra@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Simon Marchi <simon.marchi@ericsson.com>, =?UTF-8?B?5L2V6ZGr?= <sayounara@hnu.edu.cn>
List-Id: lttng-dev@lists.lttng.org

On 15 November 2015 at 14:58, Michel Dagenais
<michel.dagenais@polymtl.ca> wrote:
> Simon Marchi worked on the Xeon Phi. He should be able to tell you more. Basically the Phi is compatible with older "pentium" presumably a design decision to put simpler cores but more of them. Thus, some of the later additions (e.g., a few specialized instructions) are missing.

Indeed, it was possible at the time to build lttng-tools and lttng-ust
fo the Phi.  Since urcu is a dependency of those, it means it was
possible to build it as well.

As Michel said, the serializing instructions used for the regular x86
(mfence?) port are not available on the Phi, so urcu treats it like an
old x86 processor.  See:
https://git.lttng.org/?p=urcu.git;a=commit;h=8496c88699ea71aea6a8a244f20df4fcd558ffba

However, I see that you are building with icc and not gcc.  I don't
think I have tried that.  Would you mind trying to build with the Xeon
Phi's gcc?  I think it's called x86_64-k1om-linux-gcc and is bundled
with Intel's MPSS.  It's possible that using icc confuses the
architecture auto-detection.

Finally, providing the config.log (you can pastebin it) would help
identify what happens.

Simon
