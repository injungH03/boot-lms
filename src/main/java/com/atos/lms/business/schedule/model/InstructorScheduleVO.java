package com.atos.lms.business.schedule.model;


import com.atos.lms.common.model.MasterVO;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class InstructorScheduleVO extends MasterVO {

    /* atos_instructor_schedule */
	private int scheduleCode;
	private String instructor;
	private String mainEvent;
    private String startDate;
    private String endDate;
    private int allDay;
    private String scheduleColor;

    /* atos_member */
    private String id;
	private String name;
    private String roleId;





}
