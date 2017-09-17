package com.csx.workflow.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Paint;
import java.awt.RenderingHints;
import java.awt.Stroke;
import java.awt.geom.RoundRectangle2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;

import org.activiti.image.exception.ActivitiImageException;
import org.activiti.image.impl.DefaultProcessDiagramCanvas;
import org.activiti.image.util.ReflectUtil;

public class HMProcessDiagramCanvas extends DefaultProcessDiagramCanvas {
	protected static Color HIGHLIGHT_COLOR = Color.green;
	public HMProcessDiagramCanvas(int width, int height, int minX, int minY,
			String imageType) {
		super(width, height, minX, minY, imageType);
		this.activityFontName = "宋体";
		this.labelFontName = "宋体";
		this.annotationFontName = "宋体";
		initialize(imageType);
	}
	  public InputStream generateImage(String imageType) {
		    if (closed) {
		      throw new ActivitiImageException("ProcessDiagramGenerator already closed");
		    }

		    ByteArrayOutputStream out = new ByteArrayOutputStream();
		    try {
		      ImageIO.write(processDiagram, imageType, out);
		      
		    } catch (IOException e) {
		      throw new ActivitiImageException("Error while generating process image", e);
		    } finally {
		      try {
		        if (out != null) {
		          out.close();
		          close();
		        }
		      } catch(IOException ignore) {
		      }
		    }
		    return new ByteArrayInputStream(out.toByteArray());
		  }
	static{
		try {
			USERTASK_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/userTask.png", null));
			SCRIPTTASK_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/scriptTask.png", null));
			SERVICETASK_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/serviceTask.png", null));
			RECEIVETASK_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/receiveTask.png", null));
			SENDTASK_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/sendTask.png", null));
			MANUALTASK_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/manualTask.png", null));
			BUSINESS_RULE_TASK_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/businessRuleTask.png", null));
			SHELL_TASK_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/shellTask.png", null));
			CAMEL_TASK_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/camelTask.png", null));
			MULE_TASK_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/muleTask.png", null));

			TIMER_IMAGE = ImageIO.read(ReflectUtil.getResource("org/activiti/icons/timer.png", null));
			COMPENSATE_THROW_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/compensate-throw.png", null));
			COMPENSATE_CATCH_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/compensate.png", null));
			ERROR_THROW_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/error-throw.png", null));
			ERROR_CATCH_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/error.png", null));
			MESSAGE_THROW_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/message-throw.png", null));
			MESSAGE_CATCH_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/message.png", null));
			SIGNAL_THROW_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/signal-throw.png", null));
			SIGNAL_CATCH_IMAGE = ImageIO
					.read(ReflectUtil.getResource("org/activiti/icons/signal.png", null));
		} catch (Exception e) {
			LOGGER.warn("Could not load image for process diagram creation: {}", e.getMessage());
		}
	}
	public void drawHighLight(int x, int y, int width, int height) {
		Paint originalPaint = g.getPaint();
		Stroke originalStroke = g.getStroke();
		g.setPaint(HIGHLIGHT_COLOR);
		g.setStroke(THICK_TASK_BORDER_STROKE);

		RoundRectangle2D rect = new RoundRectangle2D.Double(x, y, width,
				height, 20, 20);
		g.draw(rect);

		g.setPaint(originalPaint);
		g.setStroke(originalStroke);
	}
	public void initialize(String imageType) {
		if ("png".equalsIgnoreCase(imageType)) {
			this.processDiagram = new BufferedImage(canvasWidth, canvasHeight,
					BufferedImage.TYPE_INT_ARGB);
		} else {
			this.processDiagram = new BufferedImage(canvasWidth, canvasHeight,
					BufferedImage.TYPE_INT_RGB);
		}

		this.g = processDiagram.createGraphics();
		if ("png".equalsIgnoreCase(imageType) == false) {
			this.g.setBackground(new Color(255, 255, 255, 0));
			this.g.clearRect(0, 0, canvasWidth, canvasHeight);
		}

		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
				RenderingHints.VALUE_ANTIALIAS_ON);
		g.setPaint(Color.black);

		Font font = new Font(activityFontName, Font.BOLD, FONT_SIZE);
		g.setFont(font);
		this.fontMetrics = g.getFontMetrics();
		LABEL_FONT = new Font(labelFontName, Font.BOLD, 14);
		ANNOTATION_FONT = new Font(annotationFontName, Font.PLAIN, FONT_SIZE);
	}
}
