From: Mohamad Gebai <mohamad.gebai-scC8bbJcJLCw5LPnMra/2Q@public.gmane.org>
Subject: Re: View for virtual machine monitoring
Date: Tue, 09 Jul 2013 16:31:15 -0400
Message-ID: <1373401875.51dc73132e713@www.imp.polymtl.ca>
References: <1373394774.51dc57569fe05@www.imp.polymtl.ca>
	<51DC6662.8080807@voxpopuli.im>
Reply-To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
In-Reply-To: <51DC6662.8080807-GLOHREzkiE4oS2+YlJWNIQ@public.gmane.org>
List-Unsubscribe: <https://dev.eclipse.org/mailman/options/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://dev.eclipse.org/mailman/private/linuxtools-dev>
List-Post: <mailto:linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://dev.eclipse.org/mailman/listinfo/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
Sender: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
To: Alexandre Montplaisir <alexmonthy-GLOHREzkiE4oS2+YlJWNIQ@public.gmane.org>
Cc: lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org, Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

> Hi Mohamad,
>
> Quite impressive!

Hi Alex,
Thank you!

> Small detail: I don't know if you use the exact same colors as the
> Control Flow View, but the color you use for "vCPU preempted" seems
> similar to the one used for the Interrupted (IRQ) state. You should make
> sure they can be differentiated if shown side-by-side. In any case, it's
> easy to tweak ;)
Actually I started from the Resource View. I agree that the colors are similar,
I hadn't noticed because I don't handle interrupts events for now. Thank you
for the comment!

> There is still some designing/reviewing to do on the required concepts,
> like experiment types and state systems for experiments. But this is a
> very good example of what it will be possible to do once those features
> are integrated (hopefully in the coming months!)

I agree!

> Cheers,
Mohamad.
