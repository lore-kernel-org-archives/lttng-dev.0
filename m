From: Alexandre Montplaisir <alexmonthy-GLOHREzkiE4oS2+YlJWNIQ@public.gmane.org>
Subject: Re: View for virtual machine monitoring
Date: Tue, 09 Jul 2013 15:37:06 -0400
Message-ID: <51DC6662.8080807@voxpopuli.im>
References: <1373394774.51dc57569fe05@www.imp.polymtl.ca>
Reply-To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
In-Reply-To: <1373394774.51dc57569fe05-AbLIzcVVHEexwLxtslwksLDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://dev.eclipse.org/mailman/options/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://dev.eclipse.org/mailman/private/linuxtools-dev>
List-Post: <mailto:linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://dev.eclipse.org/mailman/listinfo/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
Sender: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
To: Mohamad Gebai <mohamad.gebai-scC8bbJcJLCw5LPnMra/2Q@public.gmane.org>
Cc: lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org, Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mohamad,

Quite impressive!

Small detail: I don't know if you use the exact same colors as the
Control Flow View, but the color you use for "vCPU preempted" seems
similar to the one used for the Interrupted (IRQ) state. You should make
sure they can be differentiated if shown side-by-side. In any case, it's
easy to tweak ;)

There is still some designing/reviewing to do on the required concepts,
like experiment types and state systems for experiments. But this is a
very good example of what it will be possible to do once those features
are integrated (hopefully in the coming months!)

Cheers,
Alexandre



On 13-07-09 02:32 PM, Mohamad Gebai wrote:
> Hello,
> We are currently working on a new view in Eclipse's TMF plugin (Tracing and
> Monitoring Framework) specific to virtual machine analysis. This view requires
> kernel traces from the host and from each guest with a set of specific
> tracepoints activated. The traces are then merged together and analysed in a
> way that the real state of each system can be rebuilt, while taking into
> account all the interactions between the different systems.
>
> The main purpose of this view is to easily point out latency problems due to
> resource sharing. For now, we only consider CPU time, but more resources (such
> as memory allocation, disks...) will be added.
>
> Two screenshots are attached. The first one shows the virtual machines and the
> state of their respective virtual CPUs. The second screenshot gives in-depth
> information about one of the virtual CPUs, showing only the threads that
> interacted with this vCPU and their state during the time of the trace. We
> think that this approach of showing information across the layers (OS, KVM,
> guest OS, and eventually JVM...) can be helpful to investigate latency-related
> problems specific to virtual machines.
>
> Legend:
> Green: user mode
> Blue: kernel mode
> Yellow: process blocked
> Purple: vCPU preempted
> Grey: vCPU idle
>
> For the sake of our experience, we pinned vCPU0 of VM1 and vCPU0 of VM2 on the
> same physical CPU, and ran a CPU-intensive workload for one second one each one
> of them. We generated our traces using the low-overhead LTTng tracer. We can
> clearly see that during that second, both of the virtual CPUs are fighting over
> the same physical CPU.
>
> We seek any thoughts or suggestions on the effectiveness of this view or on our
> approach. Any real life problems waiting for investigation are also welcome.
>
> Mohamad Gebai
>
