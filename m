From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 4/4] tile: select HAVE_SYSCALL_TRACEPOINTS
Date: Tue, 22 Jan 2013 15:23:40 -0500
Message-ID: <50FEF54C.40209@tilera.com>
References: <1358816098-13070-1-git-send-email-simon.marchi@polymtl.ca> <1358816098-13070-4-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358816098-13070-4-git-send-email-simon.marchi@polymtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 1/21/2013 7:54 PM, Simon Marchi wrote:
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  arch/tile/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Thanks!

I took the series of four patches into the tile tree for 3.9 (removing the parentheses around the definition of NR_syscalls).

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
