From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Odd dependency for lttng-ust - resolved
Date: Fri, 25 Jan 2013 12:57:14 -0500
Message-ID: <5102C77A.5040409__36255.8530564003$1359136779$gmane$org@voxpopuli.im>
References: <3CA1A65C03C1A34C81BBC6272782E696987A76@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1TynYG-0001rJ-IM
	for lttng-dev@lists.lttng.org; Fri, 25 Jan 2013 12:58:56 -0500
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E696987A76@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, =?ISO-8859-1?Q?=22Painchaud=2C_Fr=E9d=E9?= =?ISO-8859-1?Q?ric=22?= <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

On 13-01-25 12:32 PM, Thibault, Daniel wrote:
> [...]
>
>    Until this old gold bug is fixed (which looks unlikely considering its age), maybe each package's configure.ac could be made to explicitly look into /usr/local/lib when /lib and /usr/lib fail?  Or the ReadMe files of lttng-ust and lttng-tools could be modified to mention the workaround?
>

I'm not sure if they are any distro that uses gold by default, instead
of the more venerable/tested "ld". I know Ubuntu doesn't.

I think in your case the problem was because you still had the libraries
from Ubuntu's older package installed in /usr/lib, and as you mentioned,
the linker looks in that location before trying /usr/local/lib. In such
a "custom" setup, you would need to override LDFLAGS. But someone that
has nothing installed in /usr/lib should get the libraries in
/usr/local/lib selected by the linker automatically.

Cheers,
Alexandre
