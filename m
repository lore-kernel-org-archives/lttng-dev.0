From: Aaron Spear <aspear-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: View for virtual machine monitoring
Date: Tue, 9 Jul 2013 12:23:56 -0700 (PDT)
Message-ID: <77342852.21701313.1373397836659.JavaMail.root@vmware.com>
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
To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Cc: lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org
List-Id: lttng-dev@lists.lttng.org

Hello Mohamad!

Your work looks very interesting.  I have been forced to be away from it for a couple months now due to other work priorities, but I have been building something quite similar myself. 

----- Original Message -----
> Hello,
> We are currently working on a new view in Eclipse's TMF plugin (Tracing and
> Monitoring Framework) specific to virtual machine analysis. This view
> requires
> kernel traces from the host and from each guest with a set of specific
> tracepoints activated. The traces are then merged together and analysed in a
> way that the real state of each system can be rebuilt, while taking into
> account all the interactions between the different systems.

I assume you are using LTTng for Linux, are you using it for KVM as well?  

I assume then that you are using CTF formatted traces?

Are you using TMF's CTF parser?

> The main purpose of this view is to easily point out latency problems due to
> resource sharing. For now, we only consider CPU time, but more resources
> (such
> as memory allocation, disks...) will be added.
> 
> Two screenshots are attached. The first one shows the virtual machines and
> the
> state of their respective virtual CPUs. The second screenshot gives in-depth
> information about one of the virtual CPUs, showing only the threads that
> interacted with this vCPU and their state during the time of the trace. We
> think that this approach of showing information across the layers (OS, KVM,
> guest OS, and eventually JVM...) can be helpful to investigate
> latency-related
> problems specific to virtual machines.

I agree!

> Legend:
> Green: user mode
> Blue: kernel mode
> Yellow: process blocked
> Purple: vCPU preempted
> Grey: vCPU idle
> 
> For the sake of our experience, we pinned vCPU0 of VM1 and vCPU0 of VM2 on
> the
> same physical CPU, and ran a CPU-intensive workload for one second one each
> one
> of them. We generated our traces using the low-overhead LTTng tracer. We can
> clearly see that during that second, both of the virtual CPUs are fighting
> over
> the same physical CPU.
> 
> We seek any thoughts or suggestions on the effectiveness of this view or on
> our approach. Any real life problems waiting for investigation are also welcome.

I am interested to know how you setup your view under the hood.  Did you build from the code base that was already there with the ControlFlowView (which is what I did), and then using the TMF 
state system infrastructure to model state of the various elements you wish to display?

If you look through the history on this list you will see some links that I posted to the prototype that I was working with on github as well as some screenshots.  I went with an approach of trying to make the view a generic display of hierarchical state of objects vs time, and then pluggable code that understands the event schema, iterating the events and updating the view.  I like the idea of having a view that can be data driven and so it is then fairly straight forward to plug in any sort of state vs. time in context display.  My work is incomplete, it still lacks a number of features that I intend to add including the ability to have multiple instances of the view open at the same time, all syncronized and/or a single view that aggregates the contents of many different traces.  It loo
 ks as though you are already doing that, though I can't help but wonder how you defined the hierarchy when different levels in the hierarchy have different traces.


best regards,
Aaron Spear
