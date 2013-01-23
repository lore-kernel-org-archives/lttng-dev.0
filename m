From: "Ostermueller, Erik" <Erik.Ostermueller@fisglobal.com>
Subject: Re: tracing of non-JNI java in IBM jvm
Date: Wed, 23 Jan 2013 21:46:34 +0000
Message-ID: <A94B468263DDE2448A14367F590EB97301D12F91__37941.3706985817$1358977659$gmane$org@ltcfiswmsgmb15>
References: <A94B468263DDE2448A14367F590EB97301D12EC3@ltcfiswmsgmb15>
	<2081361152.17856221.1358970308809.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.fisglobal.com ([199.200.24.190])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Erik.Ostermueller@fisglobal.com>) id 1Ty89a-0005DM-1G
	for lttng-dev@lists.lttng.org; Wed, 23 Jan 2013 16:46:42 -0500
In-Reply-To: <2081361152.17856221.1358970308809.JavaMail.root@vmware.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aaron Spear <aspear@vmware.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "linuxtools-dev@eclipse.org" <linuxtools-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

Aaron wrote:
>> not yet ready to show anyone as I hacked it together
Hacked, shmacked. Pour that code into a jar file ship it! ...just kidding.
Seriously, though, I'd love to test out your prototype to get a feel for all the pieces involved -- I'm new to lttng.
If the prototype grows into something more release-able, I might have a small amount of time to contribute some code....if nothing else, I'd be happy to some load and do some profiling of the solution.

Would also be nice to optionally capture some "state"  to attach to a single gantt trace.  For example, SOA developers (they're so picky) would want the XML input that led to a performance problem that has been traced.  The uses would be responsible for identifying which method return val or parm contained input XML.  In Trace already knows how to capture that.  Would then want the new solution to dump the XML onto thread local storage (or similar) so it could be included (somehow) in the trace output.  Does CTF support storage of additional data like this?

I'm the kernel folks are rolling their eyes... sounds like a lot of overhead....but CompuWare's DynaTrace already does this with impressively low overhead.

--Erik

-----Original Message-----
From: Aaron Spear [mailto:aspear@vmware.com]
Sent: Wednesday, January 23, 2013 1:45 PM
To: Ostermueller, Erik
Cc: lttng-dev@lists.lttng.org; Alexandre Montplaisir; linuxtools-dev@eclipse.org
Subject: Re: [lttng-dev] tracing of non-JNI java in IBM jvm

Hi Erik,

I am happy to report that I already implemented what I mentioned before as a *prototype*.  My solution has the following:

-JNI library and classes that use UST to log function entries-exits.  So I end up with a CTF log that has function entries and exits.
-extension to in-trace agent library to use this library for function entries and exits.  So, you can select a subset of classes to instrument dynamically.
-clone of the Control Flow View that understands this particular function entry and exit event schema -I have threads as the parent, and then whatever functions the thread calls as children.  If you collapse the thread, you still see intervals over which it is running which is nice.

The net result is that you can see Gantt charts of function calls in *any* java application.  All you have to do is
1) launch the java app injecting the custom in-trace agent
2) start lttng ust tracing
3) connect to the java app's injected agent and select what classes you want instrumented

See the attached screenshot that shows a very simple java application that spawns 5 threads, and each thread calls 4 functions and then exits.

I think that the idea is pretty cool and have the intent to contribute it if there is interest.  This implementation is not yet ready to show anyone as I hacked it together for a paper that I am writing.  Here are a few of the caveats about it:

1) the current implementation is quite intrusive on the java side.  Sloppy use of strings in particular.  It needs some careful architecting.  I have a number of ideas on this front, but have not yet had bandwidth to implement them.
2) There are lots of details to be worked out with the in-trace integration.  The current collection UI really needs some help.  I tried briefly to get the eclipse plugin to work with Eclipse 4, but only the RCP app seems to work for me.  I think that the "Connections" view needs to have different collection agents plugged in and you should be able to connect to a java app and dynamically select classes to instrument and/or select from sets of classes/methods.
3) My vision is to create a viewer that could do arbitrary state over time, and use CTF extensions to feed this so that the implementation is entirely data driven.  Basically any hierarchy of parent-child entries with state under them.  This particular one is, like the LTTng Control Flow View, hard coded to the event schema right now, but I can see how we can make it more general.   I should say that the guys that wrote the framework did a good job of making it useable for different things (nice work guys!) 

Note that you could in fact use it for instrumenting native applications as well of course.  The "DynamoRIO" project in particular does the same sort of thing as In Trace does (only more efficiently) so I think this is quite viable as a collection mechanism.

cheers!
Aaron Spear

----- Original Message -----
> From: "Erik Ostermueller" <Erik.Ostermueller@fisglobal.com>
> To: "Aaron Spear" <aspear@vmware.com>
> Cc: lttng-dev@lists.lttng.org, "Alexandre Montplaisir" 
> <alexmonthy@voxpopuli.im>
> Sent: Wednesday, January 23, 2013 11:03:15 AM
> Subject: RE: [lttng-dev] tracing of non-JNI java in IBM jvm
> 
> Aaron,
> 
> Sorry to have disappeared from this discussion.
> What if we went is a slightly different direction.
> 
> The InTrace tool
> (https://urldefense.proofpoint.com/v1/url?u=http://mchr3k.github.com/o
> rg.intrace/&k=%2FbkpAUdJWZuiTILCq%2FFnQg%3D%3D%0A&r=k0mtagpeWG6phJwAIzKq%2B4lTFA1JCM2OiWhVYmwwWeM%3D%0A&m=lFXy7dQ3u8Zg1jElCpolYCb7TruJrJgRwBFE22Y6%2BmY%3D%0A&s=96ea6ae0f26bd65195aad3b74892a253c5f364ba26e802b78e04d40b04f6ea10) will log start/stop times of dynamically instrumented methods to a text file (proprietary format).
> What if we simply wrote a process to convert that log to CTF, and view 
> the trace with the lttng eclipse plug-in, unmodified.
> 
> The idea would be to, at first, just support these two views:
> https://urldefense.proofpoint.com/v1/url?u=http://wiki.eclipse.org/Lin
> ux_Tools_Project/LTTng/User_Guide%23Control_Flow_View&k=%2FbkpAUdJWZui
> TILCq%2FFnQg%3D%3D%0A&r=k0mtagpeWG6phJwAIzKq%2B4lTFA1JCM2OiWhVYmwwWeM%
> 3D%0A&m=lFXy7dQ3u8Zg1jElCpolYCb7TruJrJgRwBFE22Y6%2BmY%3D%0A&s=912d647a
> 2e19035e7ceb23bfbb7ca8b2e4217d47037a04c3e4ec65862ceae233
> https://urldefense.proofpoint.com/v1/url?u=http://wiki.eclipse.org/Lin
> ux_Tools_Project/LTTng/User_Guide%23Statistics_View&k=%2FbkpAUdJWZuiTI
> LCq%2FFnQg%3D%3D%0A&r=k0mtagpeWG6phJwAIzKq%2B4lTFA1JCM2OiWhVYmwwWeM%3D
> %0A&m=lFXy7dQ3u8Zg1jElCpolYCb7TruJrJgRwBFE22Y6%2BmY%3D%0A&s=b8aa3bbc7e
> 1bd3611941f0be18ced0000cd89295515ff32346c71549cc49ea26
> 
> --Erik
> 
> 
> 
> -----Original Message-----
> From: Aaron Spear [mailto:aspear@vmware.com]
> Sent: Friday, January 11, 2013 12:56 PM
> To: Ostermueller, Erik
> Cc: lttng-dev@lists.lttng.org; Alexandre Montplaisir
> Subject: Re: [lttng-dev] tracing of non-JNI java in IBM jvm
> 
> 
> ----- Original Message -----
> > From: "Erik Ostermueller" <Erik.Ostermueller@fisglobal.com>
> > To: "Alexandre Montplaisir" <alexmonthy@voxpopuli.im>
> > Cc: lttng-dev@lists.lttng.org
> > Sent: Friday, January 11, 2013 9:26:51 AM
> > Subject: Re: [lttng-dev] tracing of non-JNI java in IBM jvm
> > 
> > Thanks Alex for the quick reply....now I get it.
> > I'll jump in on that other thread you mentioned.
> > 
> > There is a tool called InTrace that does some of this work.
> > Perhaps some design ideas or even code could be stolen from here:
> >  
> > https://urldefense.proofpoint.com/v1/url?u=http://mchr3k.github.com/
> > org.intrace/&k=%2FbkpAUdJWZuiTILCq%2FFnQg%3D%3D%0A&r=k0mtagpeWG6phJw
> > AIzKq%2B4lTFA1JCM2OiWhVYmwwWeM%3D%0A&m=lFXy7dQ3u8Zg1jElCpolYCb7TruJr
> > JgRwBFE22Y6%2BmY%3D%0A&s=96ea6ae0f26bd65195aad3b74892a253c5f364ba26e
> > 802b78e04d40b04f6ea10
> > This project:
> > * implements the java.lang.instrumentation api, which can be used to 
> > plug a tracing tool into an already-running JVM.
> > * allows you to instrument/de-instrument various classes without 
> > restarting the JVM.
> > * Uses
> > https://urldefense.proofpoint.com/v1/url?u=http://asm.ow2.org/&k=%2F
> > bkpAUdJWZuiTILCq%2FFnQg%3D%3D%0A&r=k0mtagpeWG6phJwAIzKq%2B4lTFA1JCM2OiWhVYmwwWeM%3D%0A&m=lFXy7dQ3u8Zg1jElCpolYCb7TruJrJgRwBFE22Y6%2BmY%3D%0A&s=e3bd826c82ea04de7f36936be65be723da73938e69695a85c5dcc17b05bc8caf to inject byte code for entry/exit tracing methods.
> > * stores thread id (good) but does nothing to sort/organize activity 
> > by thread id into a session(bad)
> > * no graphing/aggregating of performance metrics...just displays 
> > entry/exit times, method parameters, etc...
> 
> Hi Erik,
> 
> I think that what you are mentioning is certainly one thing that is 
> needed. To me I see a couple of different components here:
> 1) implementation of java.util.logging interfaces as well as SLF4J 
> interfaces, as well as a dedicated LTTng java API for registering 
> custom event typess.  This would be used for static, compile time 
> instrumentation of java apps.
> 2) an implementation that uses the tooling you mention above for 
> dynamic instrumentation of any running java app.  You basically would 
> define trace and install trace points on the fly.  This would be 
> really, really powerful.
> 
> The implementations of the above would have to be quite different from 
> the way that things are done currently with UST.  Currently UST uses 
> macros in C files to define the various tracepoints statically.
>  We would need to have API's that could be called dynamically to 
> define tracepoints, so that the java code could do this.  I have not 
> actually looked under the hood with the current UST implementation to 
> see what the implications are for this.
> 
> It seems to me that we would want to have a Java API usage similar to 
> what you can do with SLF4J:
> 
> class MyClass {
>       private static final Tracer tracer =
>       LTTngFactory.getTracer("MyComponentName");
>       private static final String MY_TRACEPOINT =
>       "MyTracepointWithIntegerStringAndLong";
> 
>       static {
>           // register a tracepoint.  this goes through JNI and
>           creates a tracepoint
>           // in UST that has the given name and the specified objects
>           tracer.registerTracepoint(MY_TRACEPOINT,
>                                      new
>                                      Object[]{Integer.class,String.class,Long.class});
>       }
> 
>       public void someMethod() {
>           Integer someInteger = 123456;
>           String  someString = "this is the string";
>           Long  someLong = 56789;
> 
>           tracer.trace(MY_TRACEPOINT,someInteger,someString,someLong);
>       }
> }
> 
> Then over the top of this you have implementations of SLF4J, 
> java.util.logging, whatever.  The infrastructure required in the JNI 
> side for this would be the same implementation needed by the binding 
> to the InTrace technology to dynamically create tracepoints.
> 
> I need all of this right now, and am willing to spend time in the next 
> few months to implement it.
> 
> cheers,
> Aaron Spear, Staff Engineer, VMware Inc
> 
> _____________
> The information contained in this message is proprietary and/or 
> confidential. If you are not the intended recipient, please: (i) 
> delete the message and all copies; (ii) do not disclose, distribute or 
> use the message in any manner; and (iii) notify the sender 
> immediately. In addition, please be aware that any message addressed 
> to our domain is subject to archiving and review by persons other than 
> the intended recipient. Thank you
> 

_____________
The information contained in this message is proprietary and/or confidential. If you are not the intended recipient, please: (i) delete the message and all copies; (ii) do not disclose, distribute or use the message in any manner; and (iii) notify the sender immediately. In addition, please be aware that any message addressed to our domain is subject to archiving and review by persons other than the intended recipient. Thank you.
